From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 20:19:35 +0800
Subject: [PATCH 03/06] pxa3xx_nand: fix compile warning
Message-ID: <mailman.186.1282048196.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compile output as below:
WARNING: modpost: Found 1 section mismatch(es).

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 02a4466..e3061bc 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1066,7 +1066,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->chip_delay = 25;
 }

-static int pxa3xx_nand_probe(struct platform_device *pdev)
+static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
-- 
1.7.0.4

--000e0ce043362ad62d048e041b32
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0003-pxa3xx_nand-fix-compile-warning.patch"
Content-Disposition: attachment; 
	filename="0003-pxa3xx_nand-fix-compile-warning.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyq3hvh0

RnJvbSBmNjZkNDU4MTg3MTJhOTQ5OTQ1OGI0OWI1ZmMwZGRhOTM1NzAyZjUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMjIgSnVuIDIwMTAgMjA6MTk6MzUgKzA4MDAKU3ViamVjdDogW1BBVENIIDAzLzEyXSBweGEz
eHhfbmFuZDogZml4IGNvbXBpbGUgd2FybmluZwoKVGhlIGNvbXBpbGUgb3V0cHV0IGFzIGJlbG93
OgpXQVJOSU5HOiBtb2Rwb3N0OiBGb3VuZCAxIHNlY3Rpb24gbWlzbWF0Y2goZXMpLgoKU2lnbmVk
LW9mZi1ieTogTGVpIFdlbiA8bGVpd2VuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbXRkL25h
bmQvcHhhM3h4X25hbmQuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcHhhM3h4
X25hbmQuYyBiL2RyaXZlcnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYwppbmRleCAwMmE0NDY2Li5l
MzA2MWJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKKysrIGIv
ZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jCkBAIC0xMDY2LDcgKzEwNjYsNyBAQCBzdGF0
aWMgdm9pZCBweGEzeHhfbmFuZF9pbml0X210ZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwKIAl0aGlz
LT5jaGlwX2RlbGF5ID0gMjU7CiB9CiAKLXN0YXRpYyBpbnQgcHhhM3h4X25hbmRfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3N0YXRpYyBpbnQgX19kZXZpbml0IHB4YTN4eF9u
YW5kX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IHB4YTN4
eF9uYW5kX3BsYXRmb3JtX2RhdGEgKnBkYXRhOwogCXN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICpp
bmZvOwotLSAKMS43LjAuNAoK
--000e0ce043362ad62d048e041b32--


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.210.1282609719.27306.linux-arm-kernel@lists.infradead.org>

drivers/usb/core/hub.c.

Any ideas?

Regards,
Hartley=


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.228.1283456688.27306.linux-arm-kernel@lists.infradead.org>

> + =A0 =A0 =A0 struct clk *clk0;
> +
> + =A0 =A0 =A0 clk0 =3D clk_get_sys("mtu0", NULL);
> +
> + =A0 =A0 =A0 clk_enable(clk0);
> +
> +       if (clk_get_rate(clk0) > (16 << 20))
> +               cr |=3D MTU_CRn_PRESCALE_16;
> +       else
> +               cr |=3D MTU_CRn_PRESCALE_1;

To here can be removed actually.

We happen to know that this rate is not changing on the
MTU using systems.

And since we know the rate is not going to change...

Just save the rate and prescaler setting in a static local variable
and remove the other clock lookup and divisions.
(You still need to have a struct clk* pointer around for
enable/disable too.)

> (...)
> =A0void __init nmdk_timer_init(void)
> =A0{
> =A0 =A0 =A0 =A0unsigned long rate;
> =A0 =A0 =A0 =A0struct clk *clk0;
> - =A0 =A0 =A0 u32 cr;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* On MTU block 0: timer0 is used as source,
> + =A0 =A0 =A0 =A0* timer1 is used for events.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0clk0 =3D clk_get_sys("mtu0", NULL);
> =A0 =A0 =A0 =A0BUG_ON(IS_ERR(clk0));
>
> - =A0 =A0 =A0 clk_enable(clk0);
> -
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
> + =A0 =A0 =A0 =A0* Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for =
ux500:
> =A0 =A0 =A0 =A0 * use a divide-by-16 counter if it's more than 16MHz
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 cr =3D MTU_CRn_32BITS;;
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(clk0);
> - =A0 =A0 =A0 if (rate > 16 << 20) {
> + =A0 =A0 =A0 if (rate > (16 << 20))

Whatever it is we're gonna look for check it agains
a #define like

#define PRESCALER_16_LIMIT (1 << 20)

(Or whatever we would come up with in this thread)
And:

if (rate > PRESCALER_16_LIMIT)

.. whatever that may be in the end...


Yours,
Linus Walleij


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.229.1283456741.27306.linux-arm-kernel@lists.infradead.org>

> + =A0 =A0 =A0 struct clk *clk0;
> +
> + =A0 =A0 =A0 clk0 =3D clk_get_sys("mtu0", NULL);
> +
> + =A0 =A0 =A0 clk_enable(clk0);
> +
> +       if (clk_get_rate(clk0) > (16 << 20))
> +               cr |=3D MTU_CRn_PRESCALE_16;
> +       else
> +               cr |=3D MTU_CRn_PRESCALE_1;

To here can be removed actually.

We happen to know that this rate is not changing on the
MTU using systems.

And since we know the rate is not going to change...

Just save the rate and prescaler setting in a static local variable
and remove the other clock lookup and divisions.
(You still need to have a struct clk* pointer around for
enable/disable too.)

> (...)
> =A0void __init nmdk_timer_init(void)
> =A0{
> =A0 =A0 =A0 =A0unsigned long rate;
> =A0 =A0 =A0 =A0struct clk *clk0;
> - =A0 =A0 =A0 u32 cr;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* On MTU block 0: timer0 is used as source,
> + =A0 =A0 =A0 =A0* timer1 is used for events.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0clk0 =3D clk_get_sys("mtu0", NULL);
> =A0 =A0 =A0 =A0BUG_ON(IS_ERR(clk0));
>
> - =A0 =A0 =A0 clk_enable(clk0);
> -
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
> + =A0 =A0 =A0 =A0* Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for =
ux500:
> =A0 =A0 =A0 =A0 * use a divide-by-16 counter if it's more than 16MHz
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 cr =3D MTU_CRn_32BITS;;
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(clk0);
> - =A0 =A0 =A0 if (rate > 16 << 20) {
> + =A0 =A0 =A0 if (rate > (16 << 20))

Whatever it is we're gonna look for check it agains
a #define like

#define PRESCALER_16_LIMIT (1 << 20)

(Or whatever we would come up with in this thread)
And:

if (rate > PRESCALER_16_LIMIT)

.. whatever that may be in the end...


Yours,
Linus Walleij


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.232.1283546836.27306.linux-arm-kernel@lists.infradead.org>

So I think this be changed to

	default 0x30008000 if \
		ARCH_S3C2410 ||\
		ARCH_S3C2440

.  Ben?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.233.1283556889.27306.linux-arm-kernel@lists.infradead.org>

    apply: fix copy/rename breakage
    
    7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught "git-apply" to
    grok a (non-git) patch that is a concatenation of separate patches that
    touch the same file number of times, by recording the postimage of patch
    application of previous round and using it as the preimage for later
    rounds.
    
    This "incremental" mode of patch application fundamentally contradicts
    with the way git rename/copy patches are designed.  When a git patch talks
    about a file A getting modified, and a new file B created out of A, like
    this:
    
        diff --git a/A b/A
        --- a/A
        +++ b/A
        ... change text here ...
        diff --git a/A b/B
        copy from A
        copy to B
        --- a/A
        +++ b/B
        ... change text here ...
    
    the second change to produce B does not depend on what is done to A with
    the first change in any way.  This is explicitly done so for reviewability
    of individual patches.
    
    With this commit, we do not look at 'fn_table' that records the postimage
    of previous round when applying a patch to produce a new file out of an
    existing file.

> How was this patch generated: with git itself?

Yes, the patch basically agrees with what I get by applying it and running

 git format-patch -M -B HEAD^..HEAD


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.234.1283864025.27306.linux-arm-kernel@lists.infradead.org>

the same thing was nacked - there are regulator API facilties for hiding
missing regulators from drivers when needed to get systems going, unless
the device genuinely can cope without supplies it should be relying on
those.


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.242.1284676037.27306.linux-arm-kernel@lists.infradead.org>

used loops that counted udelay(1) I've noticed that the
PLLE_MISC_READY is set after up to 3usecs.

> <snip>
>
>> +static struct clk_ops tegra_pcie_clk_ops =3D {
>> + =A0 =A0 =A0 .enable =A0 =A0 =3D tegra2_periph_clk_enable,
>> + =A0 =A0 =A0 .disable =A0 =A0=3D tegra2_periph_clk_disable,
>> +};
> Why is this needed? =A0Won't the regular periph ops work?

They didn't. I haven't found anything about what feeds these clocks,
can they change rate, what clock can be their parent and if there is
any muxing options for these clocks.

> <snip>
>
>> +static struct clk tegra_clk_pex =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0=3D "pex",
>> + =A0 =A0 =A0 .flags =A0 =A0 =3D PERIPH_MANUAL_RESET,
>> + =A0 =A0 =A0 .ops =A0 =A0 =A0 =3D &tegra_pcie_clk_ops,
>> + =A0 =A0 =A0 .clk_num =A0 =3D 70,
>> +};
>> +
>> +static struct clk tegra_clk_afi =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0=3D "afi",
>> + =A0 =A0 =A0 .flags =A0 =A0 =3D PERIPH_MANUAL_RESET,
>> + =A0 =A0 =A0 .ops =A0 =A0 =A0 =3D &tegra_pcie_clk_ops,
>> + =A0 =A0 =A0 .clk_num =A0 =3D 72,
>> +};
>> +
>> +/* the pcie_xclk is required for reset of PCIE subsystem */
>> +static struct clk tegra_clk_pcie_xclk =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0=3D "pcie_xclk",
>> + =A0 =A0 =A0 .clk_num =A0 =3D 74,
>> +};
> These should probably all be defined in the CLK_PERIPH table.

See the comment above :)

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
=A0 =A0 Sincerely Yours,
=A0 =A0 =A0 =A0 Mike.


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.243.1284718717.27306.linux-arm-kernel@lists.infradead.org>
