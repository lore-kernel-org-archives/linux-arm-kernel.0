From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Jun 2013 12:28:54 +0200
Subject: [PATCHv3 10/11] arm: mvebu: indicate that this platform supports
 MSI
In-Reply-To: <1371660979-21588-11-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-11-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621102853.GH12441@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 06:56:18PM +0200, Thomas Petazzoni wrote:
> Now that all the pieces are in place, we can adjust the
> mach-mvebu/Kconfig file to indicate that this platform supports MSIs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 9eb63d7..36951b1 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -15,6 +15,7 @@ config ARCH_MVEBU
>  	select ARCH_REQUIRE_GPIOLIB
>  	select MIGHT_HAVE_PCI
>  	select PCI_QUIRKS if PCI
> +	select ARCH_SUPPORTS_MSI if PCI

I think we can get rid of ARCH_SUPPORTS_MSI now. I actually wrote a
patch once to do that but haven't posted it yet. The reason is that
the new weak functions do the right thing if MSI isn't supported by
some architecture or platform.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/4f32694f/attachment-0001.sig>
