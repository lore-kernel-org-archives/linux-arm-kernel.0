From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 22 Jan 2013 17:06:37 -0800
Subject: [PATCH 1/2] usb: host: tegra: don't touch EMC clock
In-Reply-To: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
References: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130123010637.GD2024@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 05:28:22PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Clock "emc" is for the External Memory Controller. The USB driver has no
> business touching this clock directly. Remove the code that does so.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Greg, Alan, I'd like to take this patch through the Tegra tree to avoid
> any merge conflicts with the Tegra USB changes that have  recently
> happened there.
> 
> Venu, When creating your patch to convert the Tegra USB PHY driver to a
> platform driver, can you assume these patches are applied first? Thanks.
> I assume that these patches make sense to you; could you ack them if so.
> ---
>  drivers/usb/host/ehci-tegra.c |   17 -----------------
>  1 file changed, 17 deletions(-)

I always love to see code deleted, so feel free to take this through
your tree:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
