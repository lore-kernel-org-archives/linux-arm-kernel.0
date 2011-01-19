From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 13:02:02 +0000
Subject: [PATCH] ARM: SMDK6410: Mark regulator setup data __initdata
In-Reply-To: <1295441694-16050-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1295441694-16050-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110119130202.GE31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 12:54:54PM +0000, Mark Brown wrote:
> Now that the regulator API copies out the constraints we can discard
> the static data once we're done booting, meaning we don't need to
> carry copies of data for regulators not in the system.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |   38 ++++++++++++++++----------------
>  1 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index 9fea1c2..c8a84be 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -303,14 +303,14 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>  
>  #ifdef CONFIG_REGULATOR
>  /* ARM core */
> -static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
> +static __initdata struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {

Convention says it should be layed out as:

static struct regulator_consumer_supply smdk6410_vddarm_consumers[] __initdata = {
