From: cxie4@marvell.com (Chao Xie)
Date: Mon, 22 Nov 2010 19:12:52 -0800
Subject: [PATCH 1/2] pxa: add usb clock for pxa168/pxa910
In-Reply-To: <AANLkTimq2--4rXRO9XbL3DnsTQhJmh-A4b3RarMy1xa=@mail.gmail.com>
References: <1290418347-6861-1-git-send-email-chao.xie@marvell.com>
	<AANLkTimq2--4rXRO9XbL3DnsTQhJmh-A4b3RarMy1xa=@mail.gmail.com>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D15054F6FCA@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
Modified as you suggested. Patch is attached.
...
	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
...

-----Original Message-----
From: Eric Miao [mailto:eric.y.miao at gmail.com] 
Sent: Monday, November 22, 2010 9:21 PM
To: Chao Xie
Cc: gregkh at suse.de; linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Chao Xie
Subject: Re: [PATCH 1/2] pxa: add usb clock for pxa168/pxa910

On Mon, Nov 22, 2010 at 5:32 PM,  <chao.xie@marvell.com> wrote:
> From: cxie4 <cxie4@marvell.com>
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?arch/arm/mach-mmp/pxa910.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
> index 46f2d69..cf7c71a 100644
> --- a/arch/arm/mach-mmp/pxa910.c
> +++ b/arch/arm/mach-mmp/pxa910.c
> @@ -111,6 +111,7 @@ static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
> ?static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
>
> ?static APMU_CLK(nand, NAND, 0x01db, 208000000);
> +static APMU_CLK(u2o, USB, 0x1b, 480000000);
>
> ?/* device and clock bindings */
> ?static struct clk_lookup pxa910_clkregs[] = {
> @@ -123,6 +124,7 @@ static struct clk_lookup pxa910_clkregs[] = {
> ? ? ? ?INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> + ? ? ? INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),

Normally, device name is more preferred than a name string. In this
case, it will be 'pxa-u2o'.

PS: the naming is a bit inconsistent in the patch follows, the name of
the driver file is called mv_udc, but the device name is 'pxa-u2o'?

> ?};
>
> ?static int __init pxa910_init(void)
> --
> 1.6.3.3
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-pxa-add-usb-clock-for-pxa168-pxa910.patch
Type: application/octet-stream
Size: 1119 bytes
Desc: 0001-ARM-pxa-add-usb-clock-for-pxa168-pxa910.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101122/c6a1f65a/attachment.obj>
