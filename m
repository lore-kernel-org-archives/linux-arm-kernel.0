From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2012 10:32:45 +0000
Subject: [PATCH] Add the Performance Monitoring Unit to the Trimslice
 device tree
In-Reply-To: <1330740413-29260-1-git-send-email-wcohen@redhat.com>
References: <1330740413-29260-1-git-send-email-wcohen@redhat.com>
Message-ID: <20120305103245.GC31189@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 02:06:53AM +0000, William Cohen wrote:
> The tegra processor has a performance monitoring unit. However, this
> was not listed on the board-trimslice.c devices. This patch adds
> it to the list of devices and allows one to use hardware performance
> monitoring events on the trimslice machine.
> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  arch/arm/mach-tegra/board-trimslice.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
> index cd52820..0484903 100644
> --- a/arch/arm/mach-tegra/board-trimslice.c
> +++ b/arch/arm/mach-tegra/board-trimslice.c
> @@ -82,6 +82,7 @@ static struct platform_device trimslice_audio_device = {
>  
>  static struct platform_device *trimslice_devices[] __initdata = {
>  	&debug_uart,
> +	&tegra_pmu_device,
>  	&tegra_sdhci_device1,
>  	&tegra_sdhci_device4,
>  	&tegra_i2s_device1,
> -- 
> 1.7.5.2

Olof - would you be able to pick this up please? I've not been able to test
it, but since the device is already defined I'm assuming the IRQ numbers are
correct.

Cheers,

Will
