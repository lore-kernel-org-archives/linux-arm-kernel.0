From: uri.yosef@gmail.com (Uri Yosef)
Date: Fri, 15 Jan 2010 07:35:52 +0200
Subject: [PATCH] ARM: MINI2440: Fix mini2440 crash on boot due to improper
	__initdata qualifier
In-Reply-To: <c7df016d1001142131v104c1abbn984121fb5bf67dc8@mail.gmail.com>
References: <c7df016d1001140206j79bdc36ajda53e632a305107b@mail.gmail.com>
	<20100115011649.GT18532@trinity.fluff.org>
	<c7df016d1001142131v104c1abbn984121fb5bf67dc8@mail.gmail.com>
Message-ID: <c7df016d1001142135o608e0ab0mf361890566716b8d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2010 at 7:31 AM, Uri Yosef <uri.yosef@gmail.com> wrote:
> On Fri, Jan 15, 2010 at 3:16 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>> On Thu, Jan 14, 2010 at 12:06:32PM +0200, Uri Yosef wrote:
>>> From: Uri Yosef <uri.yosef@gmail.com>
>>>
>>> This patch fix mini2440 crash on boot due to improper __initdata
>>> qualifier on mini2440_led1_pdata.
>>
>> I've tried to apply this, but git-am is refusing to belive it is a valid
>> patch file. The only thing I can see wrong is that something has changed
>> the TABs in the mail into spaces. However having reduced it to a single
>> line change it is still refusing to apply.
>>
>> Applying: ARM: MINI2440: Fix mini2440 crash on boot due to improper __initdata qualifier
>> error: patch failed: arch/arm/mach-s3c2440/mach-mini2440.c:402
>> error: arch/arm/mach-s3c2440/mach-mini2440.c: patch does not apply
>> Patch failed at 0001.
>>
>> $ git apply -v yuri
>> Checking patch arch/arm/mach-s3c2440/mach-mini2440.c...
>> error: while searching for:
>> static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
>>
>> error: patch failed: arch/arm/mach-s3c2440/mach-mini2440.c:402
>> error: arch/arm/mach-s3c2440/mach-mini2440.c: patch does not apply
>>
>> seems to suggest something else got borked with the formatting.
>>
>> Please sort this out and re-send.
>>
>
> Re-send, patch file also included.
>
> diff -ruN a/arch/arm/mach-s3c2440/mach-mini2440.c
> b/arch/arm/mach-s3c2440/mach-mini2440.c
> --- a/arch/arm/mach-s3c2440/mach-mini2440.c ? ? 2010-01-13
> 07:15:00.000000000 +0200
> +++ b/arch/arm/mach-s3c2440/mach-mini2440.c ? ? 2010-01-15
> 07:27:08.789255622 +0200
> @@ -399,35 +399,35 @@
>
> ?/* LEDS */
>
> -static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led1_pdata = {
> ? ? ? ?.name ? ? ? ? ? = "led1",
> ? ? ? ?.gpio ? ? ? ? ? = S3C2410_GPB(5),
> ? ? ? ?.flags ? ? ? ? ?= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> ? ? ? ?.def_trigger ? ?= "heartbeat",
> ?};
>
> -static struct s3c24xx_led_platdata mini2440_led2_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led2_pdata = {
> ? ? ? ?.name ? ? ? ? ? = "led2",
> ? ? ? ?.gpio ? ? ? ? ? = S3C2410_GPB(6),
> ? ? ? ?.flags ? ? ? ? ?= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> ? ? ? ?.def_trigger ? ?= "nand-disk",
> ?};
>
> -static struct s3c24xx_led_platdata mini2440_led3_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led3_pdata = {
> ? ? ? ?.name ? ? ? ? ? = "led3",
> ? ? ? ?.gpio ? ? ? ? ? = S3C2410_GPB(7),
> ? ? ? ?.flags ? ? ? ? ?= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> ? ? ? ?.def_trigger ? ?= "mmc0",
> ?};
>
> -static struct s3c24xx_led_platdata mini2440_led4_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led4_pdata = {
> ? ? ? ?.name ? ? ? ? ? = "led4",
> ? ? ? ?.gpio ? ? ? ? ? = S3C2410_GPB(8),
> ? ? ? ?.flags ? ? ? ? ?= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> ? ? ? ?.def_trigger ? ?= "",
> ?};
>
> -static struct s3c24xx_led_platdata mini2440_led_backlight_pdata __initdata = {
> +static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
> ? ? ? ?.name ? ? ? ? ? = "backlight",
> ? ? ? ?.gpio ? ? ? ? ? = S3C2410_GPG(4),
> ? ? ? ?.def_trigger ? ?= "backlight",
>

Something got wrong with my previous mail.
here it is:
-------
diff -ruN a/arch/arm/mach-s3c2440/mach-mini2440.c
b/arch/arm/mach-s3c2440/mach-mini2440.c
--- a/arch/arm/mach-s3c2440/mach-mini2440.c 2010-01-13 07:15:00.000000000 +0200
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c 2010-01-15 07:27:08.789255622 +0200
@@ -399,35 +399,35 @@

 /* LEDS */

-static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led1_pdata = {
    .name       = "led1",
    .gpio       = S3C2410_GPB(5),
    .flags      = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
    .def_trigger    = "heartbeat",
 };

-static struct s3c24xx_led_platdata mini2440_led2_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led2_pdata = {
    .name       = "led2",
    .gpio       = S3C2410_GPB(6),
    .flags      = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
    .def_trigger    = "nand-disk",
 };

-static struct s3c24xx_led_platdata mini2440_led3_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led3_pdata = {
    .name       = "led3",
    .gpio       = S3C2410_GPB(7),
    .flags      = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
    .def_trigger    = "mmc0",
 };

-static struct s3c24xx_led_platdata mini2440_led4_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led4_pdata = {
    .name       = "led4",
    .gpio       = S3C2410_GPB(8),
    .flags      = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
    .def_trigger    = "",
 };

-static struct s3c24xx_led_platdata mini2440_led_backlight_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
    .name       = "backlight",
    .gpio       = S3C2410_GPG(4),
    .def_trigger    = "backlight",
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mini2440_remove_led_initdata.patch
Type: application/octet-stream
Size: 1583 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100115/f39fba60/attachment.obj>
