From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 1 Jun 2010 14:13:38 +0800
Subject: [PATCH 3/3] pxa/z2: Register WM8750
In-Reply-To: <1275317512-4239-3-git-send-email-marek.vasut@gmail.com>
References: <1275317512-4239-1-git-send-email-marek.vasut@gmail.com>
	<1275317512-4239-3-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTimoMar3sNtZyJ6jXbnxTcpUQ-JSdKJ28wUkql_n@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 10:51 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch registers the WM8750 codec on a proper place on the ZipitZ2
> machine after the WM8750 driver was converted to new API.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

This seems to be dependent on the previous z2 battery support patch.
Is this fixing the wm8750 registration bug, otherwise I'll queue this into
the -devel branch. Or you can help make this independent of the battery
support patch so I can merge this into -fix.

> ---
> ?arch/arm/mach-pxa/z2.c | ? ?5 ++++-
> ?1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 194865e..4cba5b6 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -479,7 +479,10 @@ static struct i2c_board_info __initdata z2_i2c_board_info[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?I2C_BOARD_INFO("aer915", 0x55),
> ? ? ? ? ? ? ? ?.platform_data ?= &batt_chip_info,
> - ? ? ? }
> + ? ? ? }, {
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("wm8750", 0x1b),
> + ? ? ? },
> +
> ?};
>
> ?static void __init z2_i2c_init(void)
> --
> 1.7.0
>
>
