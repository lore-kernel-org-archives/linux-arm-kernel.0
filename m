From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 1 Sep 2009 03:22:49 +0200
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <20090901000716.GD2985@elf.ucw.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<200908311306.43005.sleep_walker@suse.cz>
	<20090901000716.GD2985@elf.ucw.cz>
Message-ID: <200909010322.49142.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 1. z??? 2009 02:07:16 Pavel Machek napsal(a):
> Ahoj! / Hi!
Ahoj! / Hi! / Guten Tag!
>
> > > > > > arch/arm/mach-pxa/Kconfig                |    5 +
> > > > > > arch/arm/mach-pxa/Makefile               |    2 +-
> > > > > > arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
> > > > > > arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
> > > > > > arch/arm/mach-pxa/palmgsm.c              |  559
> > > > > > ++++++++++++++++++++++++++++++ arch/arm/mach-pxa/treo680.c       
> > > > > >       |  528 ----------------------------
> > > > >
> > > > > I don't actually care too much about the naming - as long as 685
> > > > > can stay within treo680.c, I don't see any problem with that. The
> > > > > real question is: is palmgsm.c the proper name for all these
> > > > > devices?
> > > >
> > > > Well, actually your completely right. PalmGSM is not fitting for all
> > > > devices to come, more fitting would be something like Palm
> > > > smartphones because there are CDMA devices to come too. On the other
> > > > hand, this name is the best I found so far. If you don't mind I would
> > > > even so...
> > >
> > > I believe treo680 was better name then. Don't change it if you don't
> > > need to...
> >
> > But I need to have different generic name - treo680 will be occupied by
> > Treo680 specific stuff, which makes more sense, doesn't it?
>
> And rename generic code to treo.c? Then you could have treo.c for
> generic code, and treo680.c / treo685.c for specific models...
>
> palmgsm.c sounds like driver for their GSM chip...
> 									Pavel

Yeah, or treo-common.c in case you'd want to split it into core file + model 
files. But treo.c/palm(smart)phone.c (?) seems more ok. I dont like the idea of 
splitting the code into more files (one big, and many small).

Cheers!


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.11.1253521360.2253.linux-arm-kernel@lists.infradead.org>

on other things, by the api. Are there? I would guess there is
something to do about the '.config' switch and two or three make files.
Or am I wrong here and it's more complicated than it looks to me?

> It's nice, but programming (and debugging) the RISC coprocessor it
> self will not be easy, the code that implements the "scripts" for
> each channel is provided by freescale as a byte array (see
> arch/arm/mach-mx3/sdma_script_code_xxx.h) with not much documentation
> other than the iMX31 reference manual.

By the way, freescale answered to my request for that "API document=20
MOT-SFS-IAPI-SAS-001 (Version 0.4)":=20

> this information is regarding as confidential
[...]
> One will have to sign NDA agreement with Freescale.

I didn't get why they are doing it, but that might be the reason this
api is not included in the mainline/denx kernel.

Thanks again and I will have a closer look on porting that api :-)

Cheers
Rene



Rene Wolf
LFK-Lenkflugk=F6rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra=DFe 26, 85716 Unterschlei=DFheim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net <http://www.mbda.net/>=20

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365=20


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.13.1253734826.2253.linux-arm-kernel@lists.infradead.org>

image, reboots and then users get a rescue system trough ssh. From this
point, the user can flash a new kernel and initrd which will ignore the
'root=...' the kernel argument.
All theses steps are done without serial console. Due to this wrong
memory size setting, this can't be done on ss4000e. One has to find a
serial cable (not always easy) and then not forget to every time add
the 'mem=...' stuff. Moreover, it's more fool proof. A rescue with
memory limited to 256M will always work.

I hope this will help you to ack or nack the patch.

Thanks,
Arnaud


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] pxa: extend gpio pins from 128 to 256<br><br>GPIO pins exc=
Message-ID: <mailman.16.1253875196.2253.linux-arm-kernel@lists.infradead.org>

eeds 128 pins. So extend the maximum GPIO pins to 256.<br>And extend MFP pi=
ns also.<br><br>Signed-off-by: Haojian Zhuang &lt;<a href=3D"mailto:haojian=
.zhuang@marvell.com">haojian.zhuang at marvell.com</a>&gt;<br>
---<br>=A0arch/arm/mach-pxa/include/mach/gpio.h |=A0=A0=A0 2 +-<br>=A0arch/=
arm/mach-pxa/include/mach/irqs.h |=A0=A0=A0 2 +-<br>=A0arch/arm/mach-pxa/mf=
p-pxa2xx.c=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 6 +++---<br>=A0arch/arm/mach-pxa=
/pxa3xx.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 2 +-<br>=A0arch/arm/p=
lat-pxa/include/plat/mfp.h=A0 |=A0=A0=A0 2 +-<br>
=A05 files changed, 7 insertions(+), 7 deletions(-)<br><br>diff --git a/arc=
h/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h<=
br>index b024a8b..0cd683c 100644<br>--- a/arch/arm/mach-pxa/include/mach/gp=
io.h<br>
+++ b/arch/arm/mach-pxa/include/mach/gpio.h<br>@@ -99,7 +99,7 @@<br>=A0#def=
ine GAFR(x)=A0=A0=A0 =A0=A0=A0 GPIO_REG(0x54 + (((x) &amp; 0x70) &gt;&gt; 2=
))<br>=A0<br>=A0<br>-#define NR_BUILTIN_GPIO 128<br>+#define NR_BUILTIN_GPI=
O 256<br>=A0<br>
=A0#define gpio_to_bank(gpio)=A0=A0=A0 ((gpio) &gt;&gt; 5)<br>=A0#define gp=
io_to_irq(gpio)=A0=A0=A0 IRQ_GPIO(gpio)<br>diff --git a/arch/arm/mach-pxa/i=
nclude/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h<br>index 3677a9a=
..9565b0f 100644<br>
--- a/arch/arm/mach-pxa/include/mach/irqs.h<br>+++ b/arch/arm/mach-pxa/incl=
ude/mach/irqs.h<br>@@ -106,7 +106,7 @@<br>=A0#endif<br>=A0<br>=A0#define PX=
A_GPIO_IRQ_BASE=A0=A0=A0 PXA_IRQ(96)<br>-#define PXA_GPIO_IRQ_NUM=A0=A0=A0 =
(192)<br>+#define PXA_GPIO_IRQ_NUM=A0=A0=A0 (256)<br>
=A0<br>=A0#define GPIO_2_x_TO_IRQ(x)=A0=A0=A0 (PXA_GPIO_IRQ_BASE + (x))<br>=
=A0#define IRQ_GPIO(x)=A0=A0=A0 (((x) &lt; 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_=
x_TO_IRQ(x))<br>diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach=
-pxa/mfp-pxa2xx.c<br>
index cf6b720..767db92 100644<br>--- a/arch/arm/mach-pxa/mfp-pxa2xx.c<br>++=
+ b/arch/arm/mach-pxa/mfp-pxa2xx.c<br>@@ -41,7 +41,7 @@ struct gpio_desc {<=
br>=A0=A0=A0=A0 unsigned long=A0=A0=A0 config;<br>=A0};<br>=A0<br>-static s=
truct gpio_desc gpio_desc[MFP_PIN_GPIO127 + 1];<br>
+static struct gpio_desc gpio_desc[MFP_PIN_GPIO255 + 1];<br>=A0<br>=A0stati=
c unsigned long gpdr_lpm[4];<br>=A0<br>@@ -117,7 +117,7 @@ static inline in=
t __mfp_validate(int mfp)<br>=A0{<br>=A0=A0=A0=A0 int gpio =3D mfp_to_gpio(=
mfp);<br>=A0<br>
-=A0=A0=A0 if ((mfp &gt; MFP_PIN_GPIO127) || !gpio_desc[gpio].valid) {<br>+=
=A0=A0=A0 if ((mfp &gt; MFP_PIN_GPIO255) || !gpio_desc[gpio].valid) {<br>=
=A0=A0=A0=A0 =A0=A0=A0 pr_warning(&quot;%s: GPIO%d is invalid pin\n&quot;, =
__func__, gpio);<br>=A0=A0=A0=A0 =A0=A0=A0 return -1;<br>
=A0=A0=A0=A0 }<br>@@ -169,7 +169,7 @@ int gpio_set_wake(unsigned int gpio, =
unsigned int on)<br>=A0=A0=A0=A0 struct gpio_desc *d;<br>=A0=A0=A0=A0 unsig=
ned long c, mux_taken;<br>=A0<br>-=A0=A0=A0 if (gpio &gt; mfp_to_gpio(MFP_P=
IN_GPIO127))<br>+=A0=A0=A0 if (gpio &gt; mfp_to_gpio(MFP_PIN_GPIO255))<br>
=A0=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>=A0<br>=A0=A0=A0=A0 d =3D &amp;gp=
io_desc[gpio];<br>diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-p=
xa/pxa3xx.c<br>index 09b7b1a..7783ac9 100644<br>--- a/arch/arm/mach-pxa/pxa=
3xx.c<br>+++ b/arch/arm/mach-pxa/pxa3xx.c<br>
@@ -539,7 +539,7 @@ void __init pxa3xx_init_irq(void)<br>=A0=A0=A0=A0 __asm=
__ __volatile__(&quot;mcr p15, 0, %0, c15, c1, 0\n&quot;: :&quot;r&quot;(va=
lue));<br>=A0<br>=A0=A0=A0=A0 pxa_init_irq(56, pxa3xx_set_wake);<br>-=A0=A0=
=A0 pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);<br>
+=A0=A0=A0 pxa_init_gpio(IRQ_GPIO_2_x, 2, 255, NULL);<br>=A0}<br>=A0<br>=A0=
/*<br>diff --git a/arch/arm/plat-pxa/include/plat/mfp.h b/arch/arm/plat-pxa=
/include/plat/mfp.h<br>index 22086e6..857a683 100644<br>--- a/arch/arm/plat=
-pxa/include/plat/mfp.h<br>
+++ b/arch/arm/plat-pxa/include/plat/mfp.h<br>@@ -16,7 +16,7 @@<br>=A0#ifnd=
ef __ASM_PLAT_MFP_H<br>=A0#define __ASM_PLAT_MFP_H<br>=A0<br>-#define mfp_t=
o_gpio(m)=A0=A0=A0 ((m) % 128)<br>+#define mfp_to_gpio(m)=A0=A0=A0 ((m) % 2=
56)<br>=A0<br>=A0/* list of all the configurable MFP pins */<br>
=A0enum {<br>-- <br>1.5.6.5<br><br>

--0016e646114219b34d0474649139--
--0016e646114219b354047464913b
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-pxa-extend-gpio-pins-from-128-to-256.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-extend-gpio-pins-from-128-to-256.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g019snqm0

RnJvbSAzNDE2MjhkOWM0NGQxMjAyODRjZDQ1ZThmYTVhYzliZDRhY2ZlNDY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTQ6Mjg6MTEgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBweGE6IGV4dGVuZCBncGlvIHBpbnMgZnJvbSAxMjggdG8gMjU2CgpHUElPIHBpbnMgZXhj
ZWVkcyAxMjggcGlucy4gU28gZXh0ZW5kIHRoZSBtYXhpbXVtIEdQSU8gcGlucyB0byAyNTYuCkFu
ZCBleHRlbmQgTUZQIHBpbnMgYWxzby4KClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxo
YW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRl
L21hY2gvZ3Bpby5oIHwgICAgMiArLQogYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2ly
cXMuaCB8ICAgIDIgKy0KIGFyY2gvYXJtL21hY2gtcHhhL21mcC1weGEyeHguYyAgICAgICAgfCAg
ICA2ICsrKy0tLQogYXJjaC9hcm0vbWFjaC1weGEvcHhhM3h4LmMgICAgICAgICAgICB8ICAgIDIg
Ky0KIGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9tZnAuaCAgfCAgICAyICstCiA1IGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvZ3Bpby5oIGIvYXJjaC9hcm0vbWFjaC1w
eGEvaW5jbHVkZS9tYWNoL2dwaW8uaAppbmRleCBiMDI0YThiLi4wY2Q2ODNjIDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvZ3Bpby5oCisrKyBiL2FyY2gvYXJtL21h
Y2gtcHhhL2luY2x1ZGUvbWFjaC9ncGlvLmgKQEAgLTk5LDcgKzk5LDcgQEAKICNkZWZpbmUgR0FG
Uih4KQkJR1BJT19SRUcoMHg1NCArICgoKHgpICYgMHg3MCkgPj4gMikpCiAKIAotI2RlZmluZSBO
Ul9CVUlMVElOX0dQSU8gMTI4CisjZGVmaW5lIE5SX0JVSUxUSU5fR1BJTyAyNTYKIAogI2RlZmlu
ZSBncGlvX3RvX2JhbmsoZ3BpbykJKChncGlvKSA+PiA1KQogI2RlZmluZSBncGlvX3RvX2lycShn
cGlvKQlJUlFfR1BJTyhncGlvKQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVk
ZS9tYWNoL2lycXMuaCBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9pcnFzLmgKaW5k
ZXggMzY3N2E5YS4uOTU2NWIwZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVk
ZS9tYWNoL2lycXMuaAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvaXJxcy5o
CkBAIC0xMDYsNyArMTA2LDcgQEAKICNlbmRpZgogCiAjZGVmaW5lIFBYQV9HUElPX0lSUV9CQVNF
CVBYQV9JUlEoOTYpCi0jZGVmaW5lIFBYQV9HUElPX0lSUV9OVU0JKDE5MikKKyNkZWZpbmUgUFhB
X0dQSU9fSVJRX05VTQkoMjU2KQogCiAjZGVmaW5lIEdQSU9fMl94X1RPX0lSUSh4KQkoUFhBX0dQ
SU9fSVJRX0JBU0UgKyAoeCkpCiAjZGVmaW5lIElSUV9HUElPKHgpCSgoKHgpIDwgMikgPyAoSVJR
X0dQSU8wICsgKHgpKSA6IEdQSU9fMl94X1RPX0lSUSh4KSkKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtcHhhL21mcC1weGEyeHguYyBiL2FyY2gvYXJtL21hY2gtcHhhL21mcC1weGEyeHguYwpp
bmRleCBjZjZiNzIwLi43NjdkYjkyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9tZnAt
cHhhMnh4LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvbWZwLXB4YTJ4eC5jCkBAIC00MSw3ICs0
MSw3IEBAIHN0cnVjdCBncGlvX2Rlc2MgewogCXVuc2lnbmVkIGxvbmcJY29uZmlnOwogfTsKIAot
c3RhdGljIHN0cnVjdCBncGlvX2Rlc2MgZ3Bpb19kZXNjW01GUF9QSU5fR1BJTzEyNyArIDFdOwor
c3RhdGljIHN0cnVjdCBncGlvX2Rlc2MgZ3Bpb19kZXNjW01GUF9QSU5fR1BJTzI1NSArIDFdOwog
CiBzdGF0aWMgdW5zaWduZWQgbG9uZyBncGRyX2xwbVs0XTsKIApAQCAtMTE3LDcgKzExNyw3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IF9fbWZwX3ZhbGlkYXRlKGludCBtZnApCiB7CiAJaW50IGdwaW8g
PSBtZnBfdG9fZ3BpbyhtZnApOwogCi0JaWYgKChtZnAgPiBNRlBfUElOX0dQSU8xMjcpIHx8ICFn
cGlvX2Rlc2NbZ3Bpb10udmFsaWQpIHsKKwlpZiAoKG1mcCA+IE1GUF9QSU5fR1BJTzI1NSkgfHwg
IWdwaW9fZGVzY1tncGlvXS52YWxpZCkgewogCQlwcl93YXJuaW5nKCIlczogR1BJTyVkIGlzIGlu
dmFsaWQgcGluXG4iLCBfX2Z1bmNfXywgZ3Bpbyk7CiAJCXJldHVybiAtMTsKIAl9CkBAIC0xNjks
NyArMTY5LDcgQEAgaW50IGdwaW9fc2V0X3dha2UodW5zaWduZWQgaW50IGdwaW8sIHVuc2lnbmVk
IGludCBvbikKIAlzdHJ1Y3QgZ3Bpb19kZXNjICpkOwogCXVuc2lnbmVkIGxvbmcgYywgbXV4X3Rh
a2VuOwogCi0JaWYgKGdwaW8gPiBtZnBfdG9fZ3BpbyhNRlBfUElOX0dQSU8xMjcpKQorCWlmIChn
cGlvID4gbWZwX3RvX2dwaW8oTUZQX1BJTl9HUElPMjU1KSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
IAlkID0gJmdwaW9fZGVzY1tncGlvXTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL3B4
YTN4eC5jIGIvYXJjaC9hcm0vbWFjaC1weGEvcHhhM3h4LmMKaW5kZXggMDliN2IxYS4uNzc4M2Fj
OSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvcHhhM3h4LmMKKysrIGIvYXJjaC9hcm0v
bWFjaC1weGEvcHhhM3h4LmMKQEAgLTUzOSw3ICs1MzksNyBAQCB2b2lkIF9faW5pdCBweGEzeHhf
aW5pdF9pcnEodm9pZCkKIAlfX2FzbV9fIF9fdm9sYXRpbGVfXygibWNyIHAxNSwgMCwgJTAsIGMx
NSwgYzEsIDBcbiI6IDoiciIodmFsdWUpKTsKIAogCXB4YV9pbml0X2lycSg1NiwgcHhhM3h4X3Nl
dF93YWtlKTsKLQlweGFfaW5pdF9ncGlvKElSUV9HUElPXzJfeCwgMiwgMTI3LCBOVUxMKTsKKwlw
eGFfaW5pdF9ncGlvKElSUV9HUElPXzJfeCwgMiwgMjU1LCBOVUxMKTsKIH0KIAogLyoKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9tZnAuaCBiL2FyY2gvYXJtL3Bs
YXQtcHhhL2luY2x1ZGUvcGxhdC9tZnAuaAppbmRleCAyMjA4NmU2Li44NTdhNjgzIDEwMDY0NAot
LS0gYS9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvbWZwLmgKKysrIGIvYXJjaC9hcm0v
cGxhdC1weGEvaW5jbHVkZS9wbGF0L21mcC5oCkBAIC0xNiw3ICsxNiw3IEBACiAjaWZuZGVmIF9f
QVNNX1BMQVRfTUZQX0gKICNkZWZpbmUgX19BU01fUExBVF9NRlBfSAogCi0jZGVmaW5lIG1mcF90
b19ncGlvKG0pCSgobSkgJSAxMjgpCisjZGVmaW5lIG1mcF90b19ncGlvKG0pCSgobSkgJSAyNTYp
CiAKIC8qIGxpc3Qgb2YgYWxsIHRoZSBjb25maWd1cmFibGUgTUZQIHBpbnMgKi8KIGVudW0gewot
LSAKMS41LjYuNQoK
--0016e646114219b354047464913b--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] [MTD] [NAND] pxa3xx_nand: enable PXA3xx bad block manageme=
Message-ID: <mailman.18.1253879884.2253.linux-arm-kernel@lists.infradead.org>

nt<br><br>There&#39;s a custom bad block management in PXA3xx series.<br><b=
r>This BBM needs to allocate a reserved area at the bottom of NAND chip.<br=
>
The reserved area should be protected from normal usage. The first block<br=
>of NAND is also reserved in order to storing the relocation information.<b=
r><br>When NAND controller finds a bad block, it marks the block as bad and=
<br>
allocate a unused block from reserved area in bottom. The new block is<br>u=
sed to replace the original bad one. From OS view, there&#39;s no bad block=
<br>at the time. It&#39;s handled by NAND driver. Then driver records the r=
eplacement<br>
in the first block.<br><br>The reserved area is also called as relocation a=
rea. It occupies 2% of<br>the whole NAND space.<br><br>Signed-off-by: Haoji=
an Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com">haojian.zhuang@=
marvell.com</a>&gt;<br>
---<br>=A0arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h |=A0=A0 62 ++++<br>=
=A0drivers/mtd/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 6 +<br>=A0drivers/mtd/Makefile=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 1 +<br=
>=A0drivers/mtd/nand/pxa3xx_nand.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 124 ++++++++<br>
=A0drivers/mtd/pxa3xx_bbm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 427 +++++++++++++++++++++++++++<br>=A05 files changed, 620 i=
nsertions(+), 0 deletions(-)<br>=A0create mode 100644 arch/arm/plat-pxa/inc=
lude/plat/pxa3xx_bbm.h<br>=A0create mode 100644 drivers/mtd/pxa3xx_bbm.c<br=
>
<br>diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h b/arch/arm/pla=
t-pxa/include/plat/pxa3xx_bbm.h<br>new file mode 100644<br>index 0000000..8=
508547<br>--- /dev/null<br>+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_bbm.=
h<br>
@@ -0,0 +1,62 @@<br>+#ifndef=A0=A0=A0 __PXA3XX_BBT_H__<br>+#define=A0=A0=A0=
 __PXA3XX_BBT_H__<br>+<br>+#include &lt;linux/types.h&gt;<br>+<br>+#define =
PXA_RLTABLE_HEADER=A0=A0=A0 =A0=A0=A0 (0x524e)<br>+#define PXA_MAX_RLENTRY=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 (127)<br>
+#define PXA_MAX_SLOT=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 (40)<br>+#define PXA_BEG=
IN_SLOT=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 (2)<br>+#define PXA_BBM_MAGIC=A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 (0x4c56524d)=A0=A0=A0 /* MRVL */<br>+<br>+enum {<br>+=
=A0=A0=A0 PXA3xx_BBM_NAND =3D 0,<br>+=A0=A0=A0 PXA3xx_BBM_ONENAND,<br>+=A0=
=A0=A0 PXA3xx_BBM_INVALID =3D -1,<br>
+};<br>+<br>+struct relocate_entry {<br>+=A0=A0=A0 unsigned short from;<br>=
+=A0=A0=A0 unsigned short to;<br>+};<br>+<br>+struct relocate_table {<br>+=
=A0=A0=A0 unsigned short header;<br>+=A0=A0=A0 unsigned short total;<br>+};=
<br>+<br>+struct pxa3xx_bbm {<br>
+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 magic;<br>+=A0=A0=A0 /*<br>+=A0=
=A0=A0 =A0* NOTES: this field impact the partition table. Please make sure<=
br>+=A0=A0=A0 =A0* that this value align with partitions definition.<br>+=
=A0=A0=A0 =A0*/<br>+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 max_relocate=
_entry;<br>
+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 max_slots;<br>+=A0=A0=A0 int=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 current_slot;<br>+<br>+=A0=A0=A0 void=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 *data_buf;<br>+<br>+=A0=A0=A0 /*<br>+=A0=A0=A0 =A0* The=
se two fields should be in (one)nand_chip. Add here to handle<br>+=A0=A0=A0=
 =A0* onenand_chip and nand_chip at the same time.<br>
+=A0=A0=A0 =A0*/<br>+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 page_shift;=
<br>+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 erase_shift;<br>+<br>+=A0=
=A0=A0 struct relocate_table=A0=A0=A0 *table;<br>+=A0=A0=A0 struct relocate=
_entry=A0=A0=A0 *entry;<br>+<br>+=A0=A0=A0 void=A0=A0=A0 (*uninit)(struct m=
td_info *mtd);<br>
+=A0=A0=A0 loff_t=A0=A0=A0 (*search)(struct mtd_info *mtd,=A0=A0=A0 loff_t =
ofs);<br>+=A0=A0=A0 int=A0=A0=A0 (*block_markbad)(struct mtd_info *mtd, int=
 block);<br>+=A0=A0=A0 int=A0=A0=A0 (*scan_bbt)(struct mtd_info *mtd);<br>+=
};<br>+<br>+extern int verify_nand_bbm(struct mtd_info *mtd, struct pxa3xx_=
bbm **bbm);<br>
+extern int verify_onenand_bbm(struct mtd_info *mtd, struct pxa3xx_bbm **bb=
m);<br>+extern int nand_badblockpos(struct mtd_info *mtd);<br>+extern int o=
nenand_badblockpos(struct mtd_info *mtd);<br>+extern struct pxa3xx_bbm *pxa=
3xx_query_bbm(void);<br>
+#endif<br>+<br>diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig<br>i=
ndex b8e35a0..3cdf7bf 100644<br>--- a/drivers/mtd/Kconfig<br>+++ b/drivers/=
mtd/Kconfig<br>@@ -315,6 +315,12 @@ config MTD_OOPS<br>=A0=A0=A0=A0 =A0 To =
use, add console=3DttyMTDx to the kernel command line,<br>
=A0=A0=A0=A0 =A0 where x is the MTD device number to use.<br>=A0<br>+config=
 PXA3xx_BBM<br>+=A0=A0=A0 bool &quot;Marvell PXA3xx Bad Block Management&qu=
ot;<br>+=A0=A0=A0 depends on MTD &amp;&amp; (MTD_NAND || MTD_ONENAND)<br>+=
=A0=A0=A0 help<br>+=A0=A0=A0 =A0 This enables Marvell Bad block management =
on NAND/ONENAND on PXA3xx.<br>
+<br>=A0source &quot;drivers/mtd/chips/Kconfig&quot;<br>=A0<br>=A0source &q=
uot;drivers/mtd/maps/Kconfig&quot;<br>diff --git a/drivers/mtd/Makefile b/d=
rivers/mtd/Makefile<br>index 82d1e4d..e637fa0 100644<br>--- a/drivers/mtd/M=
akefile<br>
+++ b/drivers/mtd/Makefile<br>@@ -25,6 +25,7 @@ obj-$(CONFIG_INFTL)=A0=A0=
=A0 =A0=A0=A0 +=3D inftl.o<br>=A0obj-$(CONFIG_RFD_FTL)=A0=A0=A0 =A0=A0=A0 +=
=3D rfd_ftl.o<br>=A0obj-$(CONFIG_SSFDC)=A0=A0=A0 =A0=A0=A0 +=3D ssfdc.o<br>=
=A0obj-$(CONFIG_MTD_OOPS)=A0=A0=A0 =A0=A0=A0 +=3D mtdoops.o<br>
+obj-$(CONFIG_PXA3xx_BBM)=A0=A0=A0 +=3D pxa3xx_bbm.o<br>=A0<br>=A0nftl-objs=
=A0=A0=A0 =A0=A0=A0 :=3D nftlcore.o nftlmount.o<br>=A0inftl-objs=A0=A0=A0 =
=A0=A0=A0 :=3D inftlcore.o inftlmount.o<br>diff --git a/drivers/mtd/nand/px=
a3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c<br>
index 134bfbc..d6c9524 100644<br>--- a/drivers/mtd/nand/pxa3xx_nand.c<br>++=
+ b/drivers/mtd/nand/pxa3xx_nand.c<br>@@ -24,6 +24,10 @@<br>=A0#include &lt=
;mach/dma.h&gt;<br>=A0#include &lt;plat/pxa3xx_nand.h&gt;<br>=A0<br>+#ifdef=
 CONFIG_PXA3xx_BBM<br>
+#include &lt;plat/pxa3xx_bbm.h&gt;<br>+#endif<br>+<br>=A0#define=A0=A0=A0 =
CHIP_DELAY_TIMEOUT=A0=A0=A0 (2 * HZ/10)<br>=A0<br>=A0/* registers and bit d=
efinitions */<br>@@ -112,6 +116,14 @@ enum {<br>=A0<br>=A0struct pxa3xx_nan=
d_info {<br>=A0=A0=A0=A0 struct nand_chip=A0=A0=A0 nand_chip;<br>
+#ifdef CONFIG_PXA3xx_BBM<br>+=A0=A0=A0 /*<br>+=A0=A0=A0 =A0* Restriction: =
nand_chip should be the first one of pxa3xx_nand_info.<br>+=A0=A0=A0 =A0* b=
bm should be the second one of pxa3xx_nand_info.<br>+=A0=A0=A0 =A0* Marvell=
 PXA3xx BBM always access this field to get bbm.<br>
+=A0=A0=A0 =A0*/<br>+=A0=A0=A0 struct pxa3xx_bbm=A0=A0=A0 *bbm;<br>+#endif<=
br>=A0<br>=A0=A0=A0=A0 struct platform_device=A0=A0=A0 =A0*pdev;<br>=A0=A0=
=A0=A0 const struct pxa3xx_nand_flash *flash_info;<br>@@ -365,6 +377,8 @@ s=
tatic struct pxa3xx_nand_flash *builtin_flash_types[] =3D {<br>
=A0/* convert nand flash controller clock cycles to nano-seconds */<br>=A0#=
define cycle2ns(c, clk)=A0=A0=A0 ((((c) + 1) * 1000000 + clk / 500) / (clk =
/ 1000))<br>=A0<br>+static int pxa3xx_nand_relocate_addr(struct mtd_info *m=
td, int page_addr);<br>
+<br>=A0static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,<b=
r>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 const struct pxa3xx_nan=
d_timing *t)<br>=A0{<br>@@ -706,6 +720,8 @@ static void pxa3xx_nand_cmdfunc=
(struct mtd_info *mtd, unsigned command,<br>
=A0<br>=A0=A0=A0=A0 init_completion(&amp;info-&gt;cmd_complete);<br>=A0<br>=
+=A0=A0=A0 page_addr =3D pxa3xx_nand_relocate_addr(mtd, page_addr);<br>+<br=
>=A0=A0=A0=A0 switch (command) {<br>=A0=A0=A0=A0 case NAND_CMD_READOOB:<br>=
=A0=A0=A0=A0 =A0=A0=A0 /* disable HW ECC to get all the OOB data */<br>
@@ -1165,6 +1181,113 @@ static struct nand_ecclayout hw_largepage_ecclayout=
 =3D {<br>=A0=A0=A0=A0 .oobfree =3D { {2, 38} }<br>=A0};<br>=A0<br>+#ifdef =
CONFIG_PXA3xx_BBM<br>+int verify_nand_bbm(struct mtd_info *mtd, struct pxa3=
xx_bbm **bbm)<br>
+{<br>+=A0=A0=A0 struct nand_chip *info =3D mtd-&gt;priv;<br>+=A0=A0=A0 str=
uct pxa3xx_bbm **nbbm =3D NULL;<br>+<br>+=A0=A0=A0 /* check whether current=
 flash is nand */<br>+=A0=A0=A0 nbbm =3D (struct pxa3xx_bbm **)(++info);<br=
>+=A0=A0=A0 if (((unsigned int)nbbm &lt; PAGE_OFFSET)<br>
+=A0=A0=A0 =A0=A0=A0 || ((unsigned int)*nbbm &lt; PAGE_OFFSET))<br>+=A0=A0=
=A0 =A0=A0=A0 return PXA3xx_BBM_INVALID;<br>+<br>+=A0=A0=A0 if ((*nbbm)-&gt=
;magic =3D=3D PXA_BBM_MAGIC) {<br>+=A0=A0=A0 =A0=A0=A0 pr_debug(&quot;%s:Fo=
und Nand flash.\n&quot;, __func__);<br>+=A0=A0=A0 =A0=A0=A0 *bbm =3D *nbbm;=
<br>
+=A0=A0=A0 =A0=A0=A0 return PXA3xx_BBM_NAND;<br>+=A0=A0=A0 }<br>+=A0=A0=A0 =
return PXA3xx_BBM_INVALID;<br>+}<br>+<br>+static int pxa3xx_nand_relocate_a=
ddr(struct mtd_info *mtd, int page_addr)<br>+{<br>+=A0=A0=A0 struct pxa3xx_=
nand_info *info =3D mtd-&gt;priv;<br>
+=A0=A0=A0 struct pxa3xx_bbm *bbm =3D info-&gt;bbm;<br>+=A0=A0=A0 loff_t ad=
dr;<br>+=A0=A0=A0 int ret;<br>+<br>+=A0=A0=A0 addr =3D page_addr &lt;&lt; b=
bm-&gt;page_shift;<br>+=A0=A0=A0 addr =3D bbm-&gt;search(mtd, addr);<br>+=
=A0=A0=A0 ret =3D addr &gt;&gt; bbm-&gt;page_shift;<br>
+=A0=A0=A0 return ret;<br>+}<br>+<br>+static int pxa3xx_nand_block_markbad(=
struct mtd_info *mtd, loff_t ofs)<br>+{<br>+=A0=A0=A0 struct pxa3xx_nand_in=
fo *info =3D mtd-&gt;priv;<br>+=A0=A0=A0 struct pxa3xx_bbm *bbm =3D info-&g=
t;bbm;<br>+=A0=A0=A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+=A0=A0=A0 uint8_t buf[2] =3D { 0, 0 };<br>+=A0=A0=A0 int block, ret;<br>+<=
br>+=A0=A0=A0 /* Get block number */<br>+=A0=A0=A0 block =3D (int)(ofs &gt;=
&gt; chip-&gt;bbt_erase_shift);<br>+<br>+=A0=A0=A0 /* We write two bytes, s=
o we dont have to mess with 16 bit<br>
+=A0=A0=A0 =A0* access<br>+=A0=A0=A0 =A0*/<br>+=A0=A0=A0 ofs +=3D mtd-&gt;o=
obsize;<br>+=A0=A0=A0 chip-&gt;ops.len =3D chip-&gt;ops.ooblen =3D 2;<br>+=
=A0=A0=A0 chip-&gt;ops.datbuf =3D NULL;<br>+=A0=A0=A0 chip-&gt;ops.oobbuf =
=3D buf;<br>+=A0=A0=A0 chip-&gt;ops.ooboffs =3D chip-&gt;badblockpos &amp; =
~0x01;<br>
+<br>+=A0=A0=A0 ret =3D mtd-&gt;write_oob(mtd, ofs, &amp;chip-&gt;ops);<br>=
+<br>+=A0=A0=A0 if (!ret)<br>+=A0=A0=A0 =A0=A0=A0 mtd-&gt;ecc_stats.badbloc=
ks++;<br>+<br>+=A0=A0=A0 return bbm-&gt;block_markbad(mtd, block);<br>+}<br=
>+<br>+static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0struct pxa3xx_nand_info *info)<=
br>+{<br>+=A0=A0=A0 const struct pxa3xx_nand_flash *f =3D info-&gt;flash_in=
fo;<br>+=A0=A0=A0 struct nand_chip *this =3D &amp;info-&gt;nand_chip;<br>+=
=A0=A0=A0 struct pxa3xx_bbm *bbm =3D NULL;<br>+<br>
+=A0=A0=A0 this-&gt;options =3D (f-&gt;flash_width =3D=3D 16) ? NAND_BUSWID=
TH_16: 0;<br>+<br>+=A0=A0=A0 this-&gt;waitfunc=A0=A0=A0 =A0=A0=A0 =3D pxa3x=
x_nand_waitfunc;<br>+=A0=A0=A0 this-&gt;select_chip=A0=A0=A0 =3D pxa3xx_nan=
d_select_chip;<br>+=A0=A0=A0 this-&gt;dev_ready=A0=A0=A0 =A0=A0=A0 =3D pxa3=
xx_nand_dev_ready;<br>
+=A0=A0=A0 this-&gt;cmdfunc=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_cmdfunc;<br>=
+=A0=A0=A0 this-&gt;read_word=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_read_word;=
<br>+=A0=A0=A0 this-&gt;read_byte=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_read_b=
yte;<br>+=A0=A0=A0 this-&gt;read_buf=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_rea=
d_buf;<br>
+=A0=A0=A0 this-&gt;write_buf=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_write_buf;=
<br>+=A0=A0=A0 this-&gt;verify_buf=A0=A0=A0 =3D pxa3xx_nand_verify_buf;<br>=
+<br>+=A0=A0=A0 this-&gt;ecc.mode=A0=A0=A0 =A0=A0=A0 =3D NAND_ECC_HW;<br>+=
=A0=A0=A0 this-&gt;ecc.hwctl=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_nand_ecc_hwctl;<=
br>
+=A0=A0=A0 this-&gt;ecc.calculate=A0=A0=A0 =3D pxa3xx_nand_ecc_calculate;<b=
r>+=A0=A0=A0 this-&gt;ecc.correct=A0=A0=A0 =3D pxa3xx_nand_ecc_correct;<br>=
+=A0=A0=A0 this-&gt;ecc.size=A0=A0=A0 =A0=A0=A0 =3D f-&gt;page_size;<br>+<b=
r>+=A0=A0=A0 if (f-&gt;page_size =3D=3D 2048)<br>+=A0=A0=A0 =A0=A0=A0 this-=
&gt;ecc.layout =3D &amp;hw_largepage_ecclayout;<br>
+=A0=A0=A0 else<br>+=A0=A0=A0 =A0=A0=A0 this-&gt;ecc.layout =3D &amp;hw_sma=
llpage_ecclayout;<br>+<br>+=A0=A0=A0 this-&gt;chip_delay =3D 25;<br>+<br>+=
=A0=A0=A0 bbm =3D pxa3xx_query_bbm();<br>+=A0=A0=A0 if (bbm) {<br>+=A0=A0=
=A0 =A0=A0=A0 /* Marvell PXA3xx BBM is initialized successfully */<br>
+=A0=A0=A0 =A0=A0=A0 info-&gt;bbm =3D bbm;<br>+=A0=A0=A0 =A0=A0=A0 this-&gt=
;scan_bbt =3D bbm-&gt;scan_bbt;<br>+=A0=A0=A0 =A0=A0=A0 this-&gt;block_mark=
bad =3D pxa3xx_nand_block_markbad;<br>+=A0=A0=A0 }<br>+}<br>+#else<br>+stat=
ic int pxa3xx_nand_relocate_addr(struct mtd_info *mtd, int page_addr)<br>
+{<br>+=A0=A0=A0 return page_addr;<br>+}<br>+<br>=A0static void pxa3xx_nand=
_init_mtd(struct mtd_info *mtd,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0struct pxa3xx_nand_info *info)<br>=A0{<br>@@ -1196,6 +1319,7 @@ stat=
ic void pxa3xx_nand_init_mtd(struct mtd_info *mtd,<br>
=A0<br>=A0=A0=A0=A0 this-&gt;chip_delay =3D 25;<br>=A0}<br>+#endif<br>=A0<b=
r>=A0static int pxa3xx_nand_probe(struct platform_device *pdev)<br>=A0{<br>=
diff --git a/drivers/mtd/pxa3xx_bbm.c b/drivers/mtd/pxa3xx_bbm.c<br>new fil=
e mode 100644<br>
index 0000000..bcc9a35<br>--- /dev/null<br>+++ b/drivers/mtd/pxa3xx_bbm.c<b=
r>@@ -0,0 +1,427 @@<br>+/*<br>+ * linux/drivers/mtd/pxa3xx_bbm.c<br>+ *<br>=
+ * Support bad block management on PXA3xx.<br>+ * Copyright (C) 2007 Marve=
ll International Ltd.<br>
+ *<br>+ * Haojian Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com"=
>haojian.zhuang at marvell.com</a>&gt;<br>+ *<br>+ * This program is free soft=
ware; you can redistribute it and/or modify<br>+ * it under the terms of th=
e GNU General Public License version 2 as<br>
+ * published by the Free Software Foundation.<br>+ *<br>+ */<br>+<br>+#inc=
lude &lt;linux/mtd/mtd.h&gt;<br>+#include &lt;linux/mtd/nand.h&gt;<br>+#inc=
lude &lt;plat/pxa3xx_bbm.h&gt;<br>+#include &lt;asm/errno.h&gt;<br>+<br>
+static struct pxa3xx_bbm *pxa3xx_bbm =3D NULL;<br>+<br>+/*<br>+ * bbm shou=
ld be the next field of nand_chip or onenand_chip.<br>+ */<br>+static int v=
erify_bbm_magic(struct mtd_info *mtd, struct pxa3xx_bbm **bbm)<br>+{<br>+=
=A0=A0=A0 int ret;<br>
+<br>+=A0=A0=A0 ret =3D verify_nand_bbm(mtd, bbm);<br>+=A0=A0=A0 return ret=
;<br>+}<br>+<br>+static void dump_rltable(struct pxa3xx_bbm *bbm)<br>+{<br>=
+=A0=A0=A0 int i;<br>+<br>+=A0=A0=A0 if (bbm-&gt;table-&gt;total =3D=3D 0) =
{<br>+=A0=A0=A0 =A0=A0=A0 pr_info(&quot;The relocation table is empty now\n=
&quot;);<br>
+=A0=A0=A0 =A0=A0=A0 return;<br>+=A0=A0=A0 }<br>+=A0=A0=A0 for (i =3D 0; i =
&lt; bbm-&gt;table-&gt;total; i++) {<br>+=A0=A0=A0 =A0=A0=A0 if (bbm-&gt;en=
try[i].from =3D=3D (unsigned short)(-1))<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
continue;<br>+=A0=A0=A0 =A0=A0=A0 if (bbm-&gt;entry[i].to =3D=3D (unsigned =
short)(-1))<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pr_info(&quot;(%4d): block #%d is bad in rel=
ocation area\n&quot;,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i, bbm-&g=
t;entry[i].from);<br>+=A0=A0=A0 =A0=A0=A0 else<br>+=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 pr_info(&quot;(%4d): block #%d is relocated to #%d\n&quot;,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i, bbm-&gt;entry[i].from, bbm-&gt;=
entry[i].to);<br>+=A0=A0=A0 }<br>+}<br>+<br>+/* Initialize the relocation t=
able */<br>+static int pxa3xx_init_rltable(struct mtd_info *mtd)<br>+{<br>+=
=A0=A0=A0 struct pxa3xx_bbm *bbm =3D NULL;<br>
+=A0=A0=A0 int size =3D mtd-&gt;writesize + mtd-&gt;oobsize;<br>+=A0=A0=A0 =
int pages, entries;<br>+<br>+=A0=A0=A0 if (verify_bbm_magic(mtd, &amp;bbm) =
&lt; 0) {<br>+=A0=A0=A0 =A0=A0=A0 /* BBM don&#39;t support this type of fla=
sh */<br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>
+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 bbm-&gt;page_shift =3D ffs(mtd-&gt;writesiz=
e) - 1;<br>+=A0=A0=A0 bbm-&gt;erase_shift =3D ffs(mtd-&gt;erasesize) - 1;<b=
r>+<br>+=A0=A0=A0 pages =3D mtd-&gt;erasesize &gt;&gt; bbm-&gt;page_shift;<=
br>+<br>+=A0=A0=A0 entries =3D mtd-&gt;size &gt;&gt; bbm-&gt;erase_shift;<b=
r>
+=A0=A0=A0 entries =3D (entries * 2) / 100;<br>+=A0=A0=A0 if (mtd-&gt;write=
size =3D=3D 512)<br>+=A0=A0=A0 =A0=A0=A0 entries =3D (entries &lt; PXA_MAX_=
RLENTRY) ? entries<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 : PXA_MAX_RLENTRY;=
<br>+<br>+=A0=A0=A0 bbm-&gt;max_slots=A0=A0=A0 =3D PXA_MAX_SLOT;<br>
+=A0=A0=A0 bbm-&gt;max_relocate_entry =3D entries;<br>+=A0=A0=A0 bbm-&gt;cu=
rrent_slot =3D -1;<br>+<br>+=A0=A0=A0 bbm-&gt;data_buf =3D kzalloc(size, GF=
P_KERNEL);<br>+=A0=A0=A0 if (bbm-&gt;data_buf =3D=3D NULL)<br>+=A0=A0=A0 =
=A0=A0=A0 return -ENOMEM;<br>+<br>+=A0=A0=A0 bbm-&gt;table =3D (struct relo=
cate_table *)bbm-&gt;data_buf;<br>
+=A0=A0=A0 memset(bbm-&gt;table, 0, sizeof(struct relocate_table));<br>+<br=
>+=A0=A0=A0 bbm-&gt;entry =3D (struct relocate_entry *)((uint8_t *)bbm-&gt;=
data_buf +<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 sizeof(struct relocate_entry))=
;<br>+=A0=A0=A0 memset(bbm-&gt;entry, 0, sizeof(struct relocate_entry)<br>
+=A0=A0=A0 =A0=A0=A0 * bbm-&gt;max_relocate_entry);<br>+<br>+=A0=A0=A0 retu=
rn 0;<br>+}<br>+<br>+/* Uninitialize the relocation table */<br>+static voi=
d pxa3xx_uninit_rltable(struct mtd_info *mtd)<br>+{<br>+=A0=A0=A0 struct px=
a3xx_bbm *bbm =3D NULL;<br>
+<br>+=A0=A0=A0 if (verify_bbm_magic(mtd, &amp;bbm) &lt; 0) {<br>+=A0=A0=A0=
 =A0=A0=A0 /* BBM don&#39;t support this flash type */<br>+=A0=A0=A0 =A0=A0=
=A0 return;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 if (bbm) {<br>+=A0=A0=A0 =A0=
=A0=A0 kfree(bbm-&gt;data_buf);<br>+=A0=A0=A0 =A0=A0=A0 bbm =3D NULL;<br>
+=A0=A0=A0 }<br>+}<br>+<br>+/*<br>+ * Move larger data to left of pivot, an=
d move smaller data to right of<br>+ * pivot.<br>+ */<br>+static int partit=
ion(unsigned short *array, int left, int right, int pivot_idx)<br>+{<br>+=
=A0=A0=A0 int i, pivot, base_idx;<br>
+<br>+=A0=A0=A0 pivot =3D array[pivot_idx];<br>+=A0=A0=A0 swap(array[left],=
 array[right]);<br>+=A0=A0=A0 base_idx =3D left;<br>+<br>+=A0=A0=A0 for (i =
=3D left; i &lt; right; i++) {<br>+=A0=A0=A0 =A0=A0=A0 if (array[i] &gt; pi=
vot) {<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 swap(array[i], array[base_idx]);<b=
r>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 base_idx++;<br>+=A0=A0=A0 =A0=A0=A0 }<br>+=
=A0=A0=A0 }<br>+=A0=A0=A0 if (base_idx &lt; right)<br>+=A0=A0=A0 =A0=A0=A0 =
swap(array[base_idx], array[right]);<br>+=A0=A0=A0 return base_idx;<br>+}<b=
r>+<br>+static int quick_sort(unsigned short *array, int left, int right)<b=
r>
+{<br>+=A0=A0=A0 int pivot_idx, new_idx;<br>+=A0=A0=A0 if (right &gt; left)=
 {<br>+=A0=A0=A0 =A0=A0=A0 pivot_idx =3D left;<br>+=A0=A0=A0 =A0=A0=A0 new_=
idx =3D partition(array, left, right, pivot_idx);<br>+=A0=A0=A0 =A0=A0=A0 q=
uick_sort(array, left, new_idx - 1);<br>+=A0=A0=A0 =A0=A0=A0 quick_sort(arr=
ay, new_idx + 1, right);<br>
+=A0=A0=A0 }<br>+=A0=A0=A0 return 0;<br>+}<br>+<br>+/*<br>+ * Add the reloc=
ation entry into the relocation table. If the relocated block<br>+ * is bad=
, an new entry will be added into the bottom of the relocation table.<br>+ =
*/<br>+int update_rltable(struct mtd_info *mtd, int block)<br>
+{<br>+=A0=A0=A0 struct pxa3xx_bbm *bbm =3D NULL;<br>+=A0=A0=A0 struct relo=
cate_table *table =3D NULL;<br>+=A0=A0=A0 struct relocate_entry *entry =3D =
NULL;<br>+=A0=A0=A0 struct erase_info instr;<br>+=A0=A0=A0 unsigned short a=
rray[PXA_MAX_RLENTRY], addr;<br>
+=A0=A0=A0 int i, idx, ret, relocated_idx =3D -1;<br>+<br>+=A0=A0=A0 if (ve=
rify_bbm_magic(mtd, &amp;bbm) &lt; 0) {<br>+=A0=A0=A0 =A0=A0=A0 /* BBM don&=
#39;t support this type of flash */<br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;=
<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 table =3D bbm-&gt;table;<br>
+=A0=A0=A0 entry =3D bbm-&gt;entry;<br>+<br>+=A0=A0=A0 /* identify whether =
the block has been relocated */<br>+=A0=A0=A0 for (i =3D 0; i &lt; table-&g=
t;total; i++) {<br>+=A0=A0=A0 =A0=A0=A0 if (entry[i].from =3D=3D (unsigned =
short)(-1))<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;<br>
+=A0=A0=A0 =A0=A0=A0 if (block =3D=3D entry[i].from) {<br>+=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 relocated_idx =3D i;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;=
<br>+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 }<br>+<br>+scan:<br>+=A0=A0=A0 if =
(table-&gt;total &gt; bbm-&gt;max_relocate_entry) {<br>+=A0=A0=A0 =A0=A0=A0=
 pr_warning(&quot;Relocation entries exceed max num. Can&#39;t relocate&quo=
t;);<br>
+=A0=A0=A0 =A0=A0=A0 pr_warning(&quot; block 0x%x\n&quot;, block);<br>+=A0=
=A0=A0 =A0=A0=A0 return -ENOSPC;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 memset(=
array, 0, PXA_MAX_RLENTRY);<br>+=A0=A0=A0 /* Get all index of relocated blo=
cks */<br>+=A0=A0=A0 for (i =3D 0, idx =3D 0; i &lt; table-&gt;total; i++) =
{<br>
+=A0=A0=A0 =A0=A0=A0 array[idx] =3D (entry[i].to !=3D (unsigned short)(-1))=
 ? entry[i].to<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 : entry[i].from;=
<br>+=A0=A0=A0 =A0=A0=A0 idx++;<br>+=A0=A0=A0 }<br>+=A0=A0=A0 /* sort array=
 with descending order */<br>+=A0=A0=A0 quick_sort(array, 0, idx - 1);<br>
+=A0=A0=A0 /*<br>+=A0=A0=A0 =A0* find the available block with the largest =
number in reservered<br>+=A0=A0=A0 =A0* area<br>+=A0=A0=A0 =A0*/<br>+=A0=A0=
=A0 addr =3D (unsigned short)((mtd-&gt;size &gt;&gt; bbm-&gt;erase_shift) -=
 1);<br>+=A0=A0=A0 for (i =3D 0; i &lt; bbm-&gt;max_relocate_entry; i++, ad=
dr--) {<br>
+=A0=A0=A0 =A0=A0=A0 if (addr &lt; ((mtd-&gt;size &gt;&gt; bbm-&gt;erase_sh=
ift)<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 - bbm-&gt;max_relocate_entry)) {<br>=
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pr_warning(&quot;Relocation area is already =
full!\n&quot;);<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return -ENOSPC;<br>
+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 =A0=A0=A0 if (array[i] &lt; addr) {<br=
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 memset(&amp;instr, 0, sizeof(struct erase_i=
nfo));<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 instr.mtd =3D mtd;<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 instr.addr =3D addr &lt;&lt; bbm-&gt;erase_shift;<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 instr.len =3D 1 &lt;&lt; bbm-&gt;erase_shift;=
<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D mtd-&gt;erase(mtd, &amp;instr);<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (ret =3D=3D 0) {<br>+=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 /* fill the recorder into relocation table */<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (relocated_idx =3D=3D -1) {<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* new entry in relocation t=
able */<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[table-&gt;total].f=
rom =3D block;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[=
table-&gt;total].to =3D addr;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 table-&gt;total++;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 goto done;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 } else {<b=
r>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* update entry in reloc=
ation table */<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[=
table-&gt;total].from<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =3D entry[relocated_idx].to;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 entry[table-&gt;total].to<br>+=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D (unsigned short)(-1);<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 table-&gt;total++;<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[relocated_idx].to =
=3D addr;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto done;<=
br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 } else {<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* append new b=
ad entry */<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[table-&gt;total].from =3D ad=
dr;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 entry[table-&gt;total].to =
=3D (unsigned short)(-1);<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 table=
-&gt;total++;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto scan;<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 =A0=A0=A0 }<br>
+=A0=A0=A0 }<br>+<br>+done:<br>+=A0=A0=A0 return 0;<br>+}<br>+<br>+/* Write=
 the relocation table back to device, if there&#39;s room. */<br>+static in=
t sync_rltable(struct mtd_info *mtd, int *idx)<br>+{<br>+=A0=A0=A0 struct p=
xa3xx_bbm *bbm =3D NULL;<br>
+=A0=A0=A0 unsigned char *tmp;<br>+=A0=A0=A0 size_t retlen;<br>+=A0=A0=A0 i=
nt len, pages;<br>+<br>+=A0=A0=A0 if (verify_bbm_magic(mtd, &amp;bbm) &lt; =
0) {<br>+=A0=A0=A0 =A0=A0=A0 /* BBM don&#39;t support this type of flash */=
<br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>
+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 pages =3D mtd-&gt;erasesize &gt;&gt; bbm-&g=
t;page_shift;<br>+=A0=A0=A0 if ((*idx &gt;=3D pages) || (*idx &lt;=3D (page=
s - bbm-&gt;max_slots))) {<br>+=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR &quot;Wr=
ong Slot is specified.\n&quot;);<br>
+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 /* =
should write to the next slot*/<br>+=A0=A0=A0 (*idx)--;<br>+<br>+=A0=A0=A0 =
len =3D 4;=A0=A0=A0 =A0=A0=A0 /* table header */<br>+=A0=A0=A0 len +=3D bbm=
-&gt;table-&gt;total &lt;&lt; 2;<br>+<br>+=A0=A0=A0 tmp =3D (unsigned char =
*)bbm-&gt;data_buf;<br>
+=A0=A0=A0 mtd-&gt;write(mtd, (*idx) &lt;&lt; bbm-&gt;page_shift,<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0 1 &lt;&lt; bbm-&gt;page_shift, &amp;retlen, tmp);<b=
r>+<br>+=A0=A0=A0 return 0;<br>+}<br>+<br>+static int pxa3xx_scan_rltable(s=
truct mtd_info *mtd)<br>+{<br>
+=A0=A0=A0 struct pxa3xx_bbm *bbm =3D NULL;<br>+=A0=A0=A0 struct relocate_t=
able *table;<br>+=A0=A0=A0 int page, max_page;<br>+=A0=A0=A0 size_t retlen;=
<br>+=A0=A0=A0 int ret, retry_count =3D 3;<br>+<br>+=A0=A0=A0 if (verify_bb=
m_magic(mtd, &amp;bbm) &lt; 0) {<br>
+=A0=A0=A0 =A0=A0=A0 /* BBM don&#39;t support this type of flash */<br>+=A0=
=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 pxa3xx_=
init_rltable(mtd);<br>+<br>+=A0=A0=A0 table =3D bbm-&gt;table;<br>+<br>+=A0=
=A0=A0 bbm-&gt;current_slot =3D -1;<br>+=A0=A0=A0 page =3D (mtd-&gt;erasesi=
ze &gt;&gt; bbm-&gt;page_shift) - bbm-&gt;max_slots;<br>
+=A0=A0=A0 max_page =3D mtd-&gt;erasesize &gt;&gt; bbm-&gt;page_shift;<br>+=
=A0=A0=A0 for (; page &lt; max_page; page++, retry_count =3D 3) {<br>+retry=
:<br>+=A0=A0=A0 =A0=A0=A0 memset(bbm-&gt;data_buf, 0, mtd-&gt;writesize + m=
td-&gt;oobsize);<br>+=A0=A0=A0 =A0=A0=A0 ret =3D mtd-&gt;read(mtd, (page &l=
t;&lt; bbm-&gt;page_shift),<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mtd-&gt;writesize, &amp;retlen, bb=
m-&gt;data_buf);<br>+=A0=A0=A0 =A0=A0=A0 if (ret =3D=3D 0) {<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 if (table-&gt;header =3D=3D PXA_RLTABLE_HEADER) {<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bbm-&gt;current_slot =3D page;<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 =A0=A0=A0 } else {<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 if (retry_count--)<br>+=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 goto retry;<br>+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 }<br>+=
=A0=A0=A0 if (bbm-&gt;current_slot !=3D -1) {<br>+=A0=A0=A0 =A0=A0=A0 pr_de=
bug(&quot;Found relocation table at page:%d\n&quot;,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bbm-&gt;current_slot);<br>+=A0=A0=A0 =A0=A0=
=A0 dump_rltable(bbm);<br>+=A0=A0=A0 } else {<br>+=A0=A0=A0 =A0=A0=A0 pr_er=
r(&quot;Can&#39;t recognize relocation table.\n&quot;);<br>+=A0=A0=A0 =A0=
=A0=A0 pr_err(&quot;CAUTION: It may cause unpredicated error\n&quot;);<br>
+=A0=A0=A0 =A0=A0=A0 pr_err(&quot;Please re-initialize the flash.\n&quot;);=
<br>+=A0=A0=A0 =A0=A0=A0 memset((unsigned char *)bbm-&gt;table, 0,<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 sizeof(struct relocate_table));<br>+=A0=A0=A0 =
=A0=A0=A0 return -EFAULT;<br>+=A0=A0=A0 }<br>+=A0=A0=A0 return 0;<br>
+}<br>+<br>+/*<br>+ * Find the relocated block of the bad one.<br>+ * If it=
&#39;s a good block, return 0. Otherwise, return a relocated one.<br>+ * id=
x points to the next relocation entry<br>+ * If the relocated block is bad,=
 an new entry will be added into the<br>
+ * bottom of the relocation table.<br>+ */<br>+static loff_t pxa3xx_search=
_rlentry(struct mtd_info *mtd, loff_t ofs)<br>+{<br>+=A0=A0=A0 struct pxa3x=
x_bbm *bbm =3D NULL;<br>+=A0=A0=A0 struct relocate_table *table =3D NULL;<b=
r>+=A0=A0=A0 struct relocate_entry *entry =3D NULL;<br>
+=A0=A0=A0 int i, block;<br>+<br>+=A0=A0=A0 /*<br>+=A0=A0=A0 =A0* In SLC, b=
lock 0 shouldn&#39;t be broken.<br>+=A0=A0=A0 =A0* In some command, address=
 is assigned to 0 if it doesn&#39;t need<br>+=A0=A0=A0 =A0* to operate addr=
ess. So just skip it.<br>+=A0=A0=A0 =A0*/<br>
+=A0=A0=A0 if (ofs &lt;=3D 0)<br>+=A0=A0=A0 =A0=A0=A0 return ofs;<br>+<br>+=
=A0=A0=A0 if (verify_bbm_magic(mtd, &amp;bbm) &lt; 0)<br>+=A0=A0=A0 =A0=A0=
=A0 return ofs;<br>+<br>+=A0=A0=A0 table =3D bbm-&gt;table;<br>+=A0=A0=A0 e=
ntry =3D bbm-&gt;entry;<br>+<br>+=A0=A0=A0 block =3D ofs &gt;&gt; bbm-&gt;e=
rase_shift;<br>
+<br>+=A0=A0=A0 if ((bbm-&gt;current_slot =3D=3D -1) || (table-&gt;total &l=
t;=3D 0)<br>+=A0=A0=A0 =A0=A0=A0 || (block &gt;=3D (mtd-&gt;size &gt;&gt; b=
bm-&gt;erase_shift)))<br>+=A0=A0=A0 =A0=A0=A0 return ofs;<br>+<br>+=A0=A0=
=A0 ofs =3D ofs - (block &lt;&lt; bbm-&gt;erase_shift);=A0=A0=A0 /* save of=
fset */<br>
+<br>+=A0=A0=A0 for (i =3D 0; i &lt; table-&gt;total; i++) {<br>+=A0=A0=A0 =
=A0=A0=A0 if (block =3D=3D entry[i].from) {<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 block =3D entry[i].to;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;<br>+=A0=
=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 }<br>+=A0=A0=A0 ofs +=3D block &lt;&lt; bb=
m-&gt;erase_shift;<br>
+=A0=A0=A0 return ofs;<br>+}<br>+<br>+static int pxa3xx_mark_rlentry(struct=
 mtd_info *mtd, int block)<br>+{<br>+=A0=A0=A0 struct pxa3xx_bbm *bbm =3D N=
ULL;<br>+=A0=A0=A0 int ret =3D 0;<br>+<br>+=A0=A0=A0 ret =3D verify_bbm_mag=
ic(mtd, &amp;bbm);<br>+=A0=A0=A0 if (ret &lt; 0) {<br>
+=A0=A0=A0 =A0=A0=A0 /* BBM don&#39;t support this type of flash */<br>+=A0=
=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 ret =3D=
 update_rltable(mtd, block);<br>+=A0=A0=A0 if (ret)<br>+=A0=A0=A0 =A0=A0=A0=
 return ret;<br>+<br>+=A0=A0=A0 return sync_rltable(mtd, &amp;(bbm-&gt;curr=
ent_slot));<br>
+}<br>+<br>+/* If Marvell BBM is used, return 0. Otherwise, return negative=
 value. */<br>+struct pxa3xx_bbm *pxa3xx_query_bbm(void)<br>+{<br>+=A0=A0=
=A0 if (pxa3xx_bbm)<br>+=A0=A0=A0 =A0=A0=A0 return pxa3xx_bbm;<br>+=A0=A0=
=A0 return NULL;<br>+}<br>
+EXPORT_SYMBOL(pxa3xx_query_bbm);<br>+<br>+static int __init pxa3xx_bbm_ini=
t(void)<br>+{<br>+=A0=A0=A0 struct pxa3xx_bbm *bbm;<br>+<br>+=A0=A0=A0 bbm =
=3D kzalloc(sizeof(struct pxa3xx_bbm), GFP_KERNEL);<br>+=A0=A0=A0 if (!bbm)=
<br>+=A0=A0=A0 =A0=A0=A0 return -ENOMEM;<br>
+<br>+=A0=A0=A0 bbm-&gt;magic=A0=A0=A0 =A0=A0=A0 =3D PXA_BBM_MAGIC;<br>+=A0=
=A0=A0 bbm-&gt;uninit=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_uninit_rltable;<br>+=A0=
=A0=A0 bbm-&gt;search=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_search_rlentry;<br>+=A0=
=A0=A0 bbm-&gt;block_markbad=A0=A0=A0 =3D pxa3xx_mark_rlentry;<br>+=A0=A0=
=A0 bbm-&gt;scan_bbt=A0=A0=A0 =A0=A0=A0 =3D pxa3xx_scan_rltable;<br>
+<br>+=A0=A0=A0 pxa3xx_bbm =3D bbm;<br>+<br>+=A0=A0=A0 return 0;<br>+}<br>+=
subsys_initcall(pxa3xx_bbm_init);<br>+<br>+static void pxa3xx_bbm_exit(void=
)<br>+{<br>+=A0=A0=A0 if (pxa3xx_bbm) {<br>+=A0=A0=A0 =A0=A0=A0 kfree(pxa3x=
x_bbm);<br>+=A0=A0=A0 =A0=A0=A0 pxa3xx_bbm =3D NULL;<br>
+=A0=A0=A0 }<br>+}<br>+module_exit(pxa3xx_bbm_exit);<br>+<br>+MODULE_LICENS=
E(&quot;GPL&quot;);<br>+MODULE_DESCRIPTION(&quot;Marvell PXA3xx Bad Block M=
anagement&quot;);<br>-- <br>1.5.6.5<br><br>

--001517741a149782ca047465a8bd--
--001517741a149782d2047465a8bf
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001--MTD-NAND-pxa3xx_nand-enable-PXA3xx-bad-block-ma.patch"
Content-Disposition: attachment; 
	filename="0001--MTD-NAND-pxa3xx_nand-enable-PXA3xx-bad-block-ma.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g01cks240

RnJvbSA3ZTViYmI1MDgyZWYyYWZhYWIwOTY2ZDYwNTMwYWY0MTMxYzBjNGVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTU6MDA6MjggLTA0MDAKU3ViamVjdDogW1BB
VENIXSBbTVREXSBbTkFORF0gcHhhM3h4X25hbmQ6IGVuYWJsZSBQWEEzeHggYmFkIGJsb2NrIG1h
bmFnZW1lbnQKClRoZXJlJ3MgYSBjdXN0b20gYmFkIGJsb2NrIG1hbmFnZW1lbnQgaW4gUFhBM3h4
IHNlcmllcy4KClRoaXMgQkJNIG5lZWRzIHRvIGFsbG9jYXRlIGEgcmVzZXJ2ZWQgYXJlYSBhdCB0
aGUgYm90dG9tIG9mIE5BTkQgY2hpcC4KVGhlIHJlc2VydmVkIGFyZWEgc2hvdWxkIGJlIHByb3Rl
Y3RlZCBmcm9tIG5vcm1hbCB1c2FnZS4gVGhlIGZpcnN0IGJsb2NrCm9mIE5BTkQgaXMgYWxzbyBy
ZXNlcnZlZCBpbiBvcmRlciB0byBzdG9yaW5nIHRoZSByZWxvY2F0aW9uIGluZm9ybWF0aW9uLgoK
V2hlbiBOQU5EIGNvbnRyb2xsZXIgZmluZHMgYSBiYWQgYmxvY2ssIGl0IG1hcmtzIHRoZSBibG9j
ayBhcyBiYWQgYW5kCmFsbG9jYXRlIGEgdW51c2VkIGJsb2NrIGZyb20gcmVzZXJ2ZWQgYXJlYSBp
biBib3R0b20uIFRoZSBuZXcgYmxvY2sgaXMKdXNlZCB0byByZXBsYWNlIHRoZSBvcmlnaW5hbCBi
YWQgb25lLiBGcm9tIE9TIHZpZXcsIHRoZXJlJ3Mgbm8gYmFkIGJsb2NrCmF0IHRoZSB0aW1lLiBJ
dCdzIGhhbmRsZWQgYnkgTkFORCBkcml2ZXIuIFRoZW4gZHJpdmVyIHJlY29yZHMgdGhlIHJlcGxh
Y2VtZW50CmluIHRoZSBmaXJzdCBibG9jay4KClRoZSByZXNlcnZlZCBhcmVhIGlzIGFsc28gY2Fs
bGVkIGFzIHJlbG9jYXRpb24gYXJlYS4gSXQgb2NjdXBpZXMgMiUgb2YKdGhlIHdob2xlIE5BTkQg
c3BhY2UuCgpTaWduZWQtb2ZmLWJ5OiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFy
dmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3B4YTN4eF9iYm0u
aCB8ICAgNjIgKysrKwogZHJpdmVycy9tdGQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDYgKwogZHJpdmVycy9tdGQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDEgKwogZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jICAgICAgICAgICAgICB8ICAx
MjQgKysrKysrKysKIGRyaXZlcnMvbXRkL3B4YTN4eF9iYm0uYyAgICAgICAgICAgICAgICAgICAg
fCAgNDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA2MjAg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvcHhhM3h4X2JibS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tdGQvcHhhM3h4X2JibS5jCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1weGEv
aW5jbHVkZS9wbGF0L3B4YTN4eF9iYm0uaCBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxh
dC9weGEzeHhfYmJtLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uODUwODU0
NwotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9weGEz
eHhfYmJtLmgKQEAgLTAsMCArMSw2MiBAQAorI2lmbmRlZglfX1BYQTNYWF9CQlRfSF9fCisjZGVm
aW5lCV9fUFhBM1hYX0JCVF9IX18KKworI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisKKyNkZWZp
bmUgUFhBX1JMVEFCTEVfSEVBREVSCQkoMHg1MjRlKQorI2RlZmluZSBQWEFfTUFYX1JMRU5UUlkJ
CQkoMTI3KQorI2RlZmluZSBQWEFfTUFYX1NMT1QJCQkoNDApCisjZGVmaW5lIFBYQV9CRUdJTl9T
TE9UCQkJKDIpCisjZGVmaW5lIFBYQV9CQk1fTUFHSUMJCQkoMHg0YzU2NTI0ZCkJLyogTVJWTCAq
LworCitlbnVtIHsKKwlQWEEzeHhfQkJNX05BTkQgPSAwLAorCVBYQTN4eF9CQk1fT05FTkFORCwK
KwlQWEEzeHhfQkJNX0lOVkFMSUQgPSAtMSwKK307CisKK3N0cnVjdCByZWxvY2F0ZV9lbnRyeSB7
CisJdW5zaWduZWQgc2hvcnQgZnJvbTsKKwl1bnNpZ25lZCBzaG9ydCB0bzsKK307CisKK3N0cnVj
dCByZWxvY2F0ZV90YWJsZSB7CisJdW5zaWduZWQgc2hvcnQgaGVhZGVyOworCXVuc2lnbmVkIHNo
b3J0IHRvdGFsOworfTsKKworc3RydWN0IHB4YTN4eF9iYm0geworCWludAkJCW1hZ2ljOworCS8q
CisJICogTk9URVM6IHRoaXMgZmllbGQgaW1wYWN0IHRoZSBwYXJ0aXRpb24gdGFibGUuIFBsZWFz
ZSBtYWtlIHN1cmUKKwkgKiB0aGF0IHRoaXMgdmFsdWUgYWxpZ24gd2l0aCBwYXJ0aXRpb25zIGRl
ZmluaXRpb24uCisJICovCisJaW50CQkJbWF4X3JlbG9jYXRlX2VudHJ5OworCWludAkJCW1heF9z
bG90czsKKwlpbnQJCQljdXJyZW50X3Nsb3Q7CisKKwl2b2lkCQkJKmRhdGFfYnVmOworCisJLyoK
KwkgKiBUaGVzZSB0d28gZmllbGRzIHNob3VsZCBiZSBpbiAob25lKW5hbmRfY2hpcC4gQWRkIGhl
cmUgdG8gaGFuZGxlCisJICogb25lbmFuZF9jaGlwIGFuZCBuYW5kX2NoaXAgYXQgdGhlIHNhbWUg
dGltZS4KKwkgKi8KKwlpbnQJCQlwYWdlX3NoaWZ0OworCWludAkJCWVyYXNlX3NoaWZ0OworCisJ
c3RydWN0IHJlbG9jYXRlX3RhYmxlCSp0YWJsZTsKKwlzdHJ1Y3QgcmVsb2NhdGVfZW50cnkJKmVu
dHJ5OworCisJdm9pZAkoKnVuaW5pdCkoc3RydWN0IG10ZF9pbmZvICptdGQpOworCWxvZmZfdAko
KnNlYXJjaCkoc3RydWN0IG10ZF9pbmZvICptdGQsCWxvZmZfdCBvZnMpOworCWludAkoKmJsb2Nr
X21hcmtiYWQpKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgYmxvY2spOworCWludAkoKnNjYW5f
YmJ0KShzdHJ1Y3QgbXRkX2luZm8gKm10ZCk7Cit9OworCitleHRlcm4gaW50IHZlcmlmeV9uYW5k
X2JibShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgc3RydWN0IHB4YTN4eF9iYm0gKipiYm0pOworZXh0
ZXJuIGludCB2ZXJpZnlfb25lbmFuZF9iYm0oc3RydWN0IG10ZF9pbmZvICptdGQsIHN0cnVjdCBw
eGEzeHhfYmJtICoqYmJtKTsKK2V4dGVybiBpbnQgbmFuZF9iYWRibG9ja3BvcyhzdHJ1Y3QgbXRk
X2luZm8gKm10ZCk7CitleHRlcm4gaW50IG9uZW5hbmRfYmFkYmxvY2twb3Moc3RydWN0IG10ZF9p
bmZvICptdGQpOworZXh0ZXJuIHN0cnVjdCBweGEzeHhfYmJtICpweGEzeHhfcXVlcnlfYmJtKHZv
aWQpOworI2VuZGlmCisKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL0tjb25maWcgYi9kcml2ZXJz
L210ZC9LY29uZmlnCmluZGV4IGI4ZTM1YTAuLjNjZGY3YmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bXRkL0tjb25maWcKKysrIGIvZHJpdmVycy9tdGQvS2NvbmZpZwpAQCAtMzE1LDYgKzMxNSwxMiBA
QCBjb25maWcgTVREX09PUFMKIAkgIFRvIHVzZSwgYWRkIGNvbnNvbGU9dHR5TVREeCB0byB0aGUg
a2VybmVsIGNvbW1hbmQgbGluZSwKIAkgIHdoZXJlIHggaXMgdGhlIE1URCBkZXZpY2UgbnVtYmVy
IHRvIHVzZS4KIAorY29uZmlnIFBYQTN4eF9CQk0KKwlib29sICJNYXJ2ZWxsIFBYQTN4eCBCYWQg
QmxvY2sgTWFuYWdlbWVudCIKKwlkZXBlbmRzIG9uIE1URCAmJiAoTVREX05BTkQgfHwgTVREX09O
RU5BTkQpCisJaGVscAorCSAgVGhpcyBlbmFibGVzIE1hcnZlbGwgQmFkIGJsb2NrIG1hbmFnZW1l
bnQgb24gTkFORC9PTkVOQU5EIG9uIFBYQTN4eC4KKwogc291cmNlICJkcml2ZXJzL210ZC9jaGlw
cy9LY29uZmlnIgogCiBzb3VyY2UgImRyaXZlcnMvbXRkL21hcHMvS2NvbmZpZyIKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL01ha2VmaWxlIGIvZHJpdmVycy9tdGQvTWFrZWZpbGUKaW5kZXggODJk
MWU0ZC4uZTYzN2ZhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvTWFrZWZpbGUKKysrIGIvZHJp
dmVycy9tdGQvTWFrZWZpbGUKQEAgLTI1LDYgKzI1LDcgQEAgb2JqLSQoQ09ORklHX0lORlRMKQkJ
Kz0gaW5mdGwubwogb2JqLSQoQ09ORklHX1JGRF9GVEwpCQkrPSByZmRfZnRsLm8KIG9iai0kKENP
TkZJR19TU0ZEQykJCSs9IHNzZmRjLm8KIG9iai0kKENPTkZJR19NVERfT09QUykJCSs9IG10ZG9v
cHMubworb2JqLSQoQ09ORklHX1BYQTN4eF9CQk0pCSs9IHB4YTN4eF9iYm0ubwogCiBuZnRsLW9i
anMJCTo9IG5mdGxjb3JlLm8gbmZ0bG1vdW50Lm8KIGluZnRsLW9ianMJCTo9IGluZnRsY29yZS5v
IGluZnRsbW91bnQubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5j
IGIvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jCmluZGV4IDEzNGJmYmMuLmQ2Yzk1MjQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYworKysgYi9kcml2ZXJz
L210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKQEAgLTI0LDYgKzI0LDEwIEBACiAjaW5jbHVkZSA8bWFj
aC9kbWEuaD4KICNpbmNsdWRlIDxwbGF0L3B4YTN4eF9uYW5kLmg+CiAKKyNpZmRlZiBDT05GSUdf
UFhBM3h4X0JCTQorI2luY2x1ZGUgPHBsYXQvcHhhM3h4X2JibS5oPgorI2VuZGlmCisKICNkZWZp
bmUJQ0hJUF9ERUxBWV9USU1FT1VUCSgyICogSFovMTApCiAKIC8qIHJlZ2lzdGVycyBhbmQgYml0
IGRlZmluaXRpb25zICovCkBAIC0xMTIsNiArMTE2LDE0IEBAIGVudW0gewogCiBzdHJ1Y3QgcHhh
M3h4X25hbmRfaW5mbyB7CiAJc3RydWN0IG5hbmRfY2hpcAluYW5kX2NoaXA7CisjaWZkZWYgQ09O
RklHX1BYQTN4eF9CQk0KKwkvKgorCSAqIFJlc3RyaWN0aW9uOiBuYW5kX2NoaXAgc2hvdWxkIGJl
IHRoZSBmaXJzdCBvbmUgb2YgcHhhM3h4X25hbmRfaW5mby4KKwkgKiBiYm0gc2hvdWxkIGJlIHRo
ZSBzZWNvbmQgb25lIG9mIHB4YTN4eF9uYW5kX2luZm8uCisJICogTWFydmVsbCBQWEEzeHggQkJN
IGFsd2F5cyBhY2Nlc3MgdGhpcyBmaWVsZCB0byBnZXQgYmJtLgorCSAqLworCXN0cnVjdCBweGEz
eHhfYmJtCSpiYm07CisjZW5kaWYKIAogCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UJICpwZGV2Owog
CWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCAqZmxhc2hfaW5mbzsKQEAgLTM2NSw2ICsz
NzcsOCBAQCBzdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoICpidWlsdGluX2ZsYXNoX3R5
cGVzW10gPSB7CiAvKiBjb252ZXJ0IG5hbmQgZmxhc2ggY29udHJvbGxlciBjbG9jayBjeWNsZXMg
dG8gbmFuby1zZWNvbmRzICovCiAjZGVmaW5lIGN5Y2xlMm5zKGMsIGNsaykJKCgoKGMpICsgMSkg
KiAxMDAwMDAwICsgY2xrIC8gNTAwKSAvIChjbGsgLyAxMDAwKSkKIAorc3RhdGljIGludCBweGEz
eHhfbmFuZF9yZWxvY2F0ZV9hZGRyKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgcGFnZV9hZGRy
KTsKKwogc3RhdGljIHZvaWQgcHhhM3h4X25hbmRfc2V0X3RpbWluZyhzdHJ1Y3QgcHhhM3h4X25h
bmRfaW5mbyAqaW5mbywKIAkJCQkgICBjb25zdCBzdHJ1Y3QgcHhhM3h4X25hbmRfdGltaW5nICp0
KQogewpAQCAtNzA2LDYgKzcyMCw4IEBAIHN0YXRpYyB2b2lkIHB4YTN4eF9uYW5kX2NtZGZ1bmMo
c3RydWN0IG10ZF9pbmZvICptdGQsIHVuc2lnbmVkIGNvbW1hbmQsCiAKIAlpbml0X2NvbXBsZXRp
b24oJmluZm8tPmNtZF9jb21wbGV0ZSk7CiAKKwlwYWdlX2FkZHIgPSBweGEzeHhfbmFuZF9yZWxv
Y2F0ZV9hZGRyKG10ZCwgcGFnZV9hZGRyKTsKKwogCXN3aXRjaCAoY29tbWFuZCkgewogCWNhc2Ug
TkFORF9DTURfUkVBRE9PQjoKIAkJLyogZGlzYWJsZSBIVyBFQ0MgdG8gZ2V0IGFsbCB0aGUgT09C
IGRhdGEgKi8KQEAgLTExNjUsNiArMTE4MSwxMTMgQEAgc3RhdGljIHN0cnVjdCBuYW5kX2VjY2xh
eW91dCBod19sYXJnZXBhZ2VfZWNjbGF5b3V0ID0gewogCS5vb2JmcmVlID0geyB7MiwgMzh9IH0K
IH07CiAKKyNpZmRlZiBDT05GSUdfUFhBM3h4X0JCTQoraW50IHZlcmlmeV9uYW5kX2JibShzdHJ1
Y3QgbXRkX2luZm8gKm10ZCwgc3RydWN0IHB4YTN4eF9iYm0gKipiYm0pCit7CisJc3RydWN0IG5h
bmRfY2hpcCAqaW5mbyA9IG10ZC0+cHJpdjsKKwlzdHJ1Y3QgcHhhM3h4X2JibSAqKm5iYm0gPSBO
VUxMOworCisJLyogY2hlY2sgd2hldGhlciBjdXJyZW50IGZsYXNoIGlzIG5hbmQgKi8KKwluYmJt
ID0gKHN0cnVjdCBweGEzeHhfYmJtICoqKSgrK2luZm8pOworCWlmICgoKHVuc2lnbmVkIGludClu
YmJtIDwgUEFHRV9PRkZTRVQpCisJCXx8ICgodW5zaWduZWQgaW50KSpuYmJtIDwgUEFHRV9PRkZT
RVQpKQorCQlyZXR1cm4gUFhBM3h4X0JCTV9JTlZBTElEOworCisJaWYgKCgqbmJibSktPm1hZ2lj
ID09IFBYQV9CQk1fTUFHSUMpIHsKKwkJcHJfZGVidWcoIiVzOkZvdW5kIE5hbmQgZmxhc2guXG4i
LCBfX2Z1bmNfXyk7CisJCSpiYm0gPSAqbmJibTsKKwkJcmV0dXJuIFBYQTN4eF9CQk1fTkFORDsK
Kwl9CisJcmV0dXJuIFBYQTN4eF9CQk1fSU5WQUxJRDsKK30KKworc3RhdGljIGludCBweGEzeHhf
bmFuZF9yZWxvY2F0ZV9hZGRyKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgcGFnZV9hZGRyKQor
eworCXN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICppbmZvID0gbXRkLT5wcml2OworCXN0cnVjdCBw
eGEzeHhfYmJtICpiYm0gPSBpbmZvLT5iYm07CisJbG9mZl90IGFkZHI7CisJaW50IHJldDsKKwor
CWFkZHIgPSBwYWdlX2FkZHIgPDwgYmJtLT5wYWdlX3NoaWZ0OworCWFkZHIgPSBiYm0tPnNlYXJj
aChtdGQsIGFkZHIpOworCXJldCA9IGFkZHIgPj4gYmJtLT5wYWdlX3NoaWZ0OworCXJldHVybiBy
ZXQ7Cit9CisKK3N0YXRpYyBpbnQgcHhhM3h4X25hbmRfYmxvY2tfbWFya2JhZChzdHJ1Y3QgbXRk
X2luZm8gKm10ZCwgbG9mZl90IG9mcykKK3sKKwlzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5m
byA9IG10ZC0+cHJpdjsKKwlzdHJ1Y3QgcHhhM3h4X2JibSAqYmJtID0gaW5mby0+YmJtOworCXN0
cnVjdCBuYW5kX2NoaXAgKmNoaXAgPSBtdGQtPnByaXY7CisJdWludDhfdCBidWZbMl0gPSB7IDAs
IDAgfTsKKwlpbnQgYmxvY2ssIHJldDsKKworCS8qIEdldCBibG9jayBudW1iZXIgKi8KKwlibG9j
ayA9IChpbnQpKG9mcyA+PiBjaGlwLT5iYnRfZXJhc2Vfc2hpZnQpOworCisJLyogV2Ugd3JpdGUg
dHdvIGJ5dGVzLCBzbyB3ZSBkb250IGhhdmUgdG8gbWVzcyB3aXRoIDE2IGJpdAorCSAqIGFjY2Vz
cworCSAqLworCW9mcyArPSBtdGQtPm9vYnNpemU7CisJY2hpcC0+b3BzLmxlbiA9IGNoaXAtPm9w
cy5vb2JsZW4gPSAyOworCWNoaXAtPm9wcy5kYXRidWYgPSBOVUxMOworCWNoaXAtPm9wcy5vb2Ji
dWYgPSBidWY7CisJY2hpcC0+b3BzLm9vYm9mZnMgPSBjaGlwLT5iYWRibG9ja3BvcyAmIH4weDAx
OworCisJcmV0ID0gbXRkLT53cml0ZV9vb2IobXRkLCBvZnMsICZjaGlwLT5vcHMpOworCisJaWYg
KCFyZXQpCisJCW10ZC0+ZWNjX3N0YXRzLmJhZGJsb2NrcysrOworCisJcmV0dXJuIGJibS0+Ymxv
Y2tfbWFya2JhZChtdGQsIGJsb2NrKTsKK30KKworc3RhdGljIHZvaWQgcHhhM3h4X25hbmRfaW5p
dF9tdGQoc3RydWN0IG10ZF9pbmZvICptdGQsCisJCQkJIHN0cnVjdCBweGEzeHhfbmFuZF9pbmZv
ICppbmZvKQoreworCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCAqZiA9IGluZm8tPmZs
YXNoX2luZm87CisJc3RydWN0IG5hbmRfY2hpcCAqdGhpcyA9ICZpbmZvLT5uYW5kX2NoaXA7CisJ
c3RydWN0IHB4YTN4eF9iYm0gKmJibSA9IE5VTEw7CisKKwl0aGlzLT5vcHRpb25zID0gKGYtPmZs
YXNoX3dpZHRoID09IDE2KSA/IE5BTkRfQlVTV0lEVEhfMTY6IDA7CisKKwl0aGlzLT53YWl0ZnVu
YwkJPSBweGEzeHhfbmFuZF93YWl0ZnVuYzsKKwl0aGlzLT5zZWxlY3RfY2hpcAk9IHB4YTN4eF9u
YW5kX3NlbGVjdF9jaGlwOworCXRoaXMtPmRldl9yZWFkeQkJPSBweGEzeHhfbmFuZF9kZXZfcmVh
ZHk7CisJdGhpcy0+Y21kZnVuYwkJPSBweGEzeHhfbmFuZF9jbWRmdW5jOworCXRoaXMtPnJlYWRf
d29yZAkJPSBweGEzeHhfbmFuZF9yZWFkX3dvcmQ7CisJdGhpcy0+cmVhZF9ieXRlCQk9IHB4YTN4
eF9uYW5kX3JlYWRfYnl0ZTsKKwl0aGlzLT5yZWFkX2J1ZgkJPSBweGEzeHhfbmFuZF9yZWFkX2J1
ZjsKKwl0aGlzLT53cml0ZV9idWYJCT0gcHhhM3h4X25hbmRfd3JpdGVfYnVmOworCXRoaXMtPnZl
cmlmeV9idWYJPSBweGEzeHhfbmFuZF92ZXJpZnlfYnVmOworCisJdGhpcy0+ZWNjLm1vZGUJCT0g
TkFORF9FQ0NfSFc7CisJdGhpcy0+ZWNjLmh3Y3RsCQk9IHB4YTN4eF9uYW5kX2VjY19od2N0bDsK
Kwl0aGlzLT5lY2MuY2FsY3VsYXRlCT0gcHhhM3h4X25hbmRfZWNjX2NhbGN1bGF0ZTsKKwl0aGlz
LT5lY2MuY29ycmVjdAk9IHB4YTN4eF9uYW5kX2VjY19jb3JyZWN0OworCXRoaXMtPmVjYy5zaXpl
CQk9IGYtPnBhZ2Vfc2l6ZTsKKworCWlmIChmLT5wYWdlX3NpemUgPT0gMjA0OCkKKwkJdGhpcy0+
ZWNjLmxheW91dCA9ICZod19sYXJnZXBhZ2VfZWNjbGF5b3V0OworCWVsc2UKKwkJdGhpcy0+ZWNj
LmxheW91dCA9ICZod19zbWFsbHBhZ2VfZWNjbGF5b3V0OworCisJdGhpcy0+Y2hpcF9kZWxheSA9
IDI1OworCisJYmJtID0gcHhhM3h4X3F1ZXJ5X2JibSgpOworCWlmIChiYm0pIHsKKwkJLyogTWFy
dmVsbCBQWEEzeHggQkJNIGlzIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseSAqLworCQlpbmZvLT5i
Ym0gPSBiYm07CisJCXRoaXMtPnNjYW5fYmJ0ID0gYmJtLT5zY2FuX2JidDsKKwkJdGhpcy0+Ymxv
Y2tfbWFya2JhZCA9IHB4YTN4eF9uYW5kX2Jsb2NrX21hcmtiYWQ7CisJfQorfQorI2Vsc2UKK3N0
YXRpYyBpbnQgcHhhM3h4X25hbmRfcmVsb2NhdGVfYWRkcihzdHJ1Y3QgbXRkX2luZm8gKm10ZCwg
aW50IHBhZ2VfYWRkcikKK3sKKwlyZXR1cm4gcGFnZV9hZGRyOworfQorCiBzdGF0aWMgdm9pZCBw
eGEzeHhfbmFuZF9pbml0X210ZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwKIAkJCQkgc3RydWN0IHB4
YTN4eF9uYW5kX2luZm8gKmluZm8pCiB7CkBAIC0xMTk2LDYgKzEzMTksNyBAQCBzdGF0aWMgdm9p
ZCBweGEzeHhfbmFuZF9pbml0X210ZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwKIAogCXRoaXMtPmNo
aXBfZGVsYXkgPSAyNTsKIH0KKyNlbmRpZgogCiBzdGF0aWMgaW50IHB4YTN4eF9uYW5kX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9weGEzeHhfYmJtLmMgYi9kcml2ZXJzL210ZC9weGEzeHhfYmJtLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uYmNjOWEzNQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
bXRkL3B4YTN4eF9iYm0uYwpAQCAtMCwwICsxLDQyNyBAQAorLyoKKyAqIGxpbnV4L2RyaXZlcnMv
bXRkL3B4YTN4eF9iYm0uYworICoKKyAqIFN1cHBvcnQgYmFkIGJsb2NrIG1hbmFnZW1lbnQgb24g
UFhBM3h4LgorICogQ29weXJpZ2h0IChDKSAyMDA3IE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQu
CisgKgorICogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgorICoK
KyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICovCisKKyNpbmNsdWRlIDxsaW51eC9tdGQvbXRkLmg+
CisjaW5jbHVkZSA8bGludXgvbXRkL25hbmQuaD4KKyNpbmNsdWRlIDxwbGF0L3B4YTN4eF9iYm0u
aD4KKyNpbmNsdWRlIDxhc20vZXJybm8uaD4KKworc3RhdGljIHN0cnVjdCBweGEzeHhfYmJtICpw
eGEzeHhfYmJtID0gTlVMTDsKKworLyoKKyAqIGJibSBzaG91bGQgYmUgdGhlIG5leHQgZmllbGQg
b2YgbmFuZF9jaGlwIG9yIG9uZW5hbmRfY2hpcC4KKyAqLworc3RhdGljIGludCB2ZXJpZnlfYmJt
X21hZ2ljKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBzdHJ1Y3QgcHhhM3h4X2JibSAqKmJibSkKK3sK
KwlpbnQgcmV0OworCisJcmV0ID0gdmVyaWZ5X25hbmRfYmJtKG10ZCwgYmJtKTsKKwlyZXR1cm4g
cmV0OworfQorCitzdGF0aWMgdm9pZCBkdW1wX3JsdGFibGUoc3RydWN0IHB4YTN4eF9iYm0gKmJi
bSkKK3sKKwlpbnQgaTsKKworCWlmIChiYm0tPnRhYmxlLT50b3RhbCA9PSAwKSB7CisJCXByX2lu
Zm8oIlRoZSByZWxvY2F0aW9uIHRhYmxlIGlzIGVtcHR5IG5vd1xuIik7CisJCXJldHVybjsKKwl9
CisJZm9yIChpID0gMDsgaSA8IGJibS0+dGFibGUtPnRvdGFsOyBpKyspIHsKKwkJaWYgKGJibS0+
ZW50cnlbaV0uZnJvbSA9PSAodW5zaWduZWQgc2hvcnQpKC0xKSkKKwkJCWNvbnRpbnVlOworCQlp
ZiAoYmJtLT5lbnRyeVtpXS50byA9PSAodW5zaWduZWQgc2hvcnQpKC0xKSkKKwkJCXByX2luZm8o
IiglNGQpOiBibG9jayAjJWQgaXMgYmFkIGluIHJlbG9jYXRpb24gYXJlYVxuIiwKKwkJCQlpLCBi
Ym0tPmVudHJ5W2ldLmZyb20pOworCQllbHNlCisJCQlwcl9pbmZvKCIoJTRkKTogYmxvY2sgIyVk
IGlzIHJlbG9jYXRlZCB0byAjJWRcbiIsCisJCQkJaSwgYmJtLT5lbnRyeVtpXS5mcm9tLCBiYm0t
PmVudHJ5W2ldLnRvKTsKKwl9Cit9CisKKy8qIEluaXRpYWxpemUgdGhlIHJlbG9jYXRpb24gdGFi
bGUgKi8KK3N0YXRpYyBpbnQgcHhhM3h4X2luaXRfcmx0YWJsZShzdHJ1Y3QgbXRkX2luZm8gKm10
ZCkKK3sKKwlzdHJ1Y3QgcHhhM3h4X2JibSAqYmJtID0gTlVMTDsKKwlpbnQgc2l6ZSA9IG10ZC0+
d3JpdGVzaXplICsgbXRkLT5vb2JzaXplOworCWludCBwYWdlcywgZW50cmllczsKKworCWlmICh2
ZXJpZnlfYmJtX21hZ2ljKG10ZCwgJmJibSkgPCAwKSB7CisJCS8qIEJCTSBkb24ndCBzdXBwb3J0
IHRoaXMgdHlwZSBvZiBmbGFzaCAqLworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwliYm0tPnBh
Z2Vfc2hpZnQgPSBmZnMobXRkLT53cml0ZXNpemUpIC0gMTsKKwliYm0tPmVyYXNlX3NoaWZ0ID0g
ZmZzKG10ZC0+ZXJhc2VzaXplKSAtIDE7CisKKwlwYWdlcyA9IG10ZC0+ZXJhc2VzaXplID4+IGJi
bS0+cGFnZV9zaGlmdDsKKworCWVudHJpZXMgPSBtdGQtPnNpemUgPj4gYmJtLT5lcmFzZV9zaGlm
dDsKKwllbnRyaWVzID0gKGVudHJpZXMgKiAyKSAvIDEwMDsKKwlpZiAobXRkLT53cml0ZXNpemUg
PT0gNTEyKQorCQllbnRyaWVzID0gKGVudHJpZXMgPCBQWEFfTUFYX1JMRU5UUlkpID8gZW50cmll
cworCQkJICA6IFBYQV9NQVhfUkxFTlRSWTsKKworCWJibS0+bWF4X3Nsb3RzCT0gUFhBX01BWF9T
TE9UOworCWJibS0+bWF4X3JlbG9jYXRlX2VudHJ5ID0gZW50cmllczsKKwliYm0tPmN1cnJlbnRf
c2xvdCA9IC0xOworCisJYmJtLT5kYXRhX2J1ZiA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7
CisJaWYgKGJibS0+ZGF0YV9idWYgPT0gTlVMTCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwliYm0t
PnRhYmxlID0gKHN0cnVjdCByZWxvY2F0ZV90YWJsZSAqKWJibS0+ZGF0YV9idWY7CisJbWVtc2V0
KGJibS0+dGFibGUsIDAsIHNpemVvZihzdHJ1Y3QgcmVsb2NhdGVfdGFibGUpKTsKKworCWJibS0+
ZW50cnkgPSAoc3RydWN0IHJlbG9jYXRlX2VudHJ5ICopKCh1aW50OF90ICopYmJtLT5kYXRhX2J1
ZiArCisJCQlzaXplb2Yoc3RydWN0IHJlbG9jYXRlX2VudHJ5KSk7CisJbWVtc2V0KGJibS0+ZW50
cnksIDAsIHNpemVvZihzdHJ1Y3QgcmVsb2NhdGVfZW50cnkpCisJCSogYmJtLT5tYXhfcmVsb2Nh
dGVfZW50cnkpOworCisJcmV0dXJuIDA7Cit9CisKKy8qIFVuaW5pdGlhbGl6ZSB0aGUgcmVsb2Nh
dGlvbiB0YWJsZSAqLworc3RhdGljIHZvaWQgcHhhM3h4X3VuaW5pdF9ybHRhYmxlKHN0cnVjdCBt
dGRfaW5mbyAqbXRkKQoreworCXN0cnVjdCBweGEzeHhfYmJtICpiYm0gPSBOVUxMOworCisJaWYg
KHZlcmlmeV9iYm1fbWFnaWMobXRkLCAmYmJtKSA8IDApIHsKKwkJLyogQkJNIGRvbid0IHN1cHBv
cnQgdGhpcyBmbGFzaCB0eXBlICovCisJCXJldHVybjsKKwl9CisKKwlpZiAoYmJtKSB7CisJCWtm
cmVlKGJibS0+ZGF0YV9idWYpOworCQliYm0gPSBOVUxMOworCX0KK30KKworLyoKKyAqIE1vdmUg
bGFyZ2VyIGRhdGEgdG8gbGVmdCBvZiBwaXZvdCwgYW5kIG1vdmUgc21hbGxlciBkYXRhIHRvIHJp
Z2h0IG9mCisgKiBwaXZvdC4KKyAqLworc3RhdGljIGludCBwYXJ0aXRpb24odW5zaWduZWQgc2hv
cnQgKmFycmF5LCBpbnQgbGVmdCwgaW50IHJpZ2h0LCBpbnQgcGl2b3RfaWR4KQoreworCWludCBp
LCBwaXZvdCwgYmFzZV9pZHg7CisKKwlwaXZvdCA9IGFycmF5W3Bpdm90X2lkeF07CisJc3dhcChh
cnJheVtsZWZ0XSwgYXJyYXlbcmlnaHRdKTsKKwliYXNlX2lkeCA9IGxlZnQ7CisKKwlmb3IgKGkg
PSBsZWZ0OyBpIDwgcmlnaHQ7IGkrKykgeworCQlpZiAoYXJyYXlbaV0gPiBwaXZvdCkgeworCQkJ
c3dhcChhcnJheVtpXSwgYXJyYXlbYmFzZV9pZHhdKTsKKwkJCWJhc2VfaWR4Kys7CisJCX0KKwl9
CisJaWYgKGJhc2VfaWR4IDwgcmlnaHQpCisJCXN3YXAoYXJyYXlbYmFzZV9pZHhdLCBhcnJheVty
aWdodF0pOworCXJldHVybiBiYXNlX2lkeDsKK30KKworc3RhdGljIGludCBxdWlja19zb3J0KHVu
c2lnbmVkIHNob3J0ICphcnJheSwgaW50IGxlZnQsIGludCByaWdodCkKK3sKKwlpbnQgcGl2b3Rf
aWR4LCBuZXdfaWR4OworCWlmIChyaWdodCA+IGxlZnQpIHsKKwkJcGl2b3RfaWR4ID0gbGVmdDsK
KwkJbmV3X2lkeCA9IHBhcnRpdGlvbihhcnJheSwgbGVmdCwgcmlnaHQsIHBpdm90X2lkeCk7CisJ
CXF1aWNrX3NvcnQoYXJyYXksIGxlZnQsIG5ld19pZHggLSAxKTsKKwkJcXVpY2tfc29ydChhcnJh
eSwgbmV3X2lkeCArIDEsIHJpZ2h0KTsKKwl9CisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiBBZGQg
dGhlIHJlbG9jYXRpb24gZW50cnkgaW50byB0aGUgcmVsb2NhdGlvbiB0YWJsZS4gSWYgdGhlIHJl
bG9jYXRlZCBibG9jaworICogaXMgYmFkLCBhbiBuZXcgZW50cnkgd2lsbCBiZSBhZGRlZCBpbnRv
IHRoZSBib3R0b20gb2YgdGhlIHJlbG9jYXRpb24gdGFibGUuCisgKi8KK2ludCB1cGRhdGVfcmx0
YWJsZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IGJsb2NrKQoreworCXN0cnVjdCBweGEzeHhf
YmJtICpiYm0gPSBOVUxMOworCXN0cnVjdCByZWxvY2F0ZV90YWJsZSAqdGFibGUgPSBOVUxMOwor
CXN0cnVjdCByZWxvY2F0ZV9lbnRyeSAqZW50cnkgPSBOVUxMOworCXN0cnVjdCBlcmFzZV9pbmZv
IGluc3RyOworCXVuc2lnbmVkIHNob3J0IGFycmF5W1BYQV9NQVhfUkxFTlRSWV0sIGFkZHI7CisJ
aW50IGksIGlkeCwgcmV0LCByZWxvY2F0ZWRfaWR4ID0gLTE7CisKKwlpZiAodmVyaWZ5X2JibV9t
YWdpYyhtdGQsICZiYm0pIDwgMCkgeworCQkvKiBCQk0gZG9uJ3Qgc3VwcG9ydCB0aGlzIHR5cGUg
b2YgZmxhc2ggKi8KKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJdGFibGUgPSBiYm0tPnRhYmxl
OworCWVudHJ5ID0gYmJtLT5lbnRyeTsKKworCS8qIGlkZW50aWZ5IHdoZXRoZXIgdGhlIGJsb2Nr
IGhhcyBiZWVuIHJlbG9jYXRlZCAqLworCWZvciAoaSA9IDA7IGkgPCB0YWJsZS0+dG90YWw7IGkr
KykgeworCQlpZiAoZW50cnlbaV0uZnJvbSA9PSAodW5zaWduZWQgc2hvcnQpKC0xKSkKKwkJCWNv
bnRpbnVlOworCQlpZiAoYmxvY2sgPT0gZW50cnlbaV0uZnJvbSkgeworCQkJcmVsb2NhdGVkX2lk
eCA9IGk7CisJCQlicmVhazsKKwkJfQorCX0KKworc2NhbjoKKwlpZiAodGFibGUtPnRvdGFsID4g
YmJtLT5tYXhfcmVsb2NhdGVfZW50cnkpIHsKKwkJcHJfd2FybmluZygiUmVsb2NhdGlvbiBlbnRy
aWVzIGV4Y2VlZCBtYXggbnVtLiBDYW4ndCByZWxvY2F0ZSIpOworCQlwcl93YXJuaW5nKCIgYmxv
Y2sgMHgleFxuIiwgYmxvY2spOworCQlyZXR1cm4gLUVOT1NQQzsKKwl9CisKKwltZW1zZXQoYXJy
YXksIDAsIFBYQV9NQVhfUkxFTlRSWSk7CisJLyogR2V0IGFsbCBpbmRleCBvZiByZWxvY2F0ZWQg
YmxvY2tzICovCisJZm9yIChpID0gMCwgaWR4ID0gMDsgaSA8IHRhYmxlLT50b3RhbDsgaSsrKSB7
CisJCWFycmF5W2lkeF0gPSAoZW50cnlbaV0udG8gIT0gKHVuc2lnbmVkIHNob3J0KSgtMSkpID8g
ZW50cnlbaV0udG8KKwkJCQk6IGVudHJ5W2ldLmZyb207CisJCWlkeCsrOworCX0KKwkvKiBzb3J0
IGFycmF5IHdpdGggZGVzY2VuZGluZyBvcmRlciAqLworCXF1aWNrX3NvcnQoYXJyYXksIDAsIGlk
eCAtIDEpOworCS8qCisJICogZmluZCB0aGUgYXZhaWxhYmxlIGJsb2NrIHdpdGggdGhlIGxhcmdl
c3QgbnVtYmVyIGluIHJlc2VydmVyZWQKKwkgKiBhcmVhCisJICovCisJYWRkciA9ICh1bnNpZ25l
ZCBzaG9ydCkoKG10ZC0+c2l6ZSA+PiBiYm0tPmVyYXNlX3NoaWZ0KSAtIDEpOworCWZvciAoaSA9
IDA7IGkgPCBiYm0tPm1heF9yZWxvY2F0ZV9lbnRyeTsgaSsrLCBhZGRyLS0pIHsKKwkJaWYgKGFk
ZHIgPCAoKG10ZC0+c2l6ZSA+PiBiYm0tPmVyYXNlX3NoaWZ0KQorCQkJLSBiYm0tPm1heF9yZWxv
Y2F0ZV9lbnRyeSkpIHsKKwkJCXByX3dhcm5pbmcoIlJlbG9jYXRpb24gYXJlYSBpcyBhbHJlYWR5
IGZ1bGwhXG4iKTsKKwkJCXJldHVybiAtRU5PU1BDOworCQl9CisJCWlmIChhcnJheVtpXSA8IGFk
ZHIpIHsKKwkJCW1lbXNldCgmaW5zdHIsIDAsIHNpemVvZihzdHJ1Y3QgZXJhc2VfaW5mbykpOwor
CQkJaW5zdHIubXRkID0gbXRkOworCQkJaW5zdHIuYWRkciA9IGFkZHIgPDwgYmJtLT5lcmFzZV9z
aGlmdDsKKwkJCWluc3RyLmxlbiA9IDEgPDwgYmJtLT5lcmFzZV9zaGlmdDsKKwkJCXJldCA9IG10
ZC0+ZXJhc2UobXRkLCAmaW5zdHIpOworCQkJaWYgKHJldCA9PSAwKSB7CisJCQkJLyogZmlsbCB0
aGUgcmVjb3JkZXIgaW50byByZWxvY2F0aW9uIHRhYmxlICovCisJCQkJaWYgKHJlbG9jYXRlZF9p
ZHggPT0gLTEpIHsKKwkJCQkJLyogbmV3IGVudHJ5IGluIHJlbG9jYXRpb24gdGFibGUgKi8KKwkJ
CQkJZW50cnlbdGFibGUtPnRvdGFsXS5mcm9tID0gYmxvY2s7CisJCQkJCWVudHJ5W3RhYmxlLT50
b3RhbF0udG8gPSBhZGRyOworCQkJCQl0YWJsZS0+dG90YWwrKzsKKwkJCQkJZ290byBkb25lOwor
CQkJCX0gZWxzZSB7CisJCQkJCS8qIHVwZGF0ZSBlbnRyeSBpbiByZWxvY2F0aW9uIHRhYmxlICov
CisJCQkJCWVudHJ5W3RhYmxlLT50b3RhbF0uZnJvbQorCQkJCQkJPSBlbnRyeVtyZWxvY2F0ZWRf
aWR4XS50bzsKKwkJCQkJZW50cnlbdGFibGUtPnRvdGFsXS50bworCQkJCQkJPSAodW5zaWduZWQg
c2hvcnQpKC0xKTsKKwkJCQkJdGFibGUtPnRvdGFsKys7CisJCQkJCWVudHJ5W3JlbG9jYXRlZF9p
ZHhdLnRvID0gYWRkcjsKKwkJCQkJZ290byBkb25lOworCQkJCX0KKwkJCX0gZWxzZSB7CisJCQkJ
LyogYXBwZW5kIG5ldyBiYWQgZW50cnkgKi8KKwkJCQllbnRyeVt0YWJsZS0+dG90YWxdLmZyb20g
PSBhZGRyOworCQkJCWVudHJ5W3RhYmxlLT50b3RhbF0udG8gPSAodW5zaWduZWQgc2hvcnQpKC0x
KTsKKwkJCQl0YWJsZS0+dG90YWwrKzsKKwkJCQlnb3RvIHNjYW47CisJCQl9CisJCX0KKwl9CisK
K2RvbmU6CisJcmV0dXJuIDA7Cit9CisKKy8qIFdyaXRlIHRoZSByZWxvY2F0aW9uIHRhYmxlIGJh
Y2sgdG8gZGV2aWNlLCBpZiB0aGVyZSdzIHJvb20uICovCitzdGF0aWMgaW50IHN5bmNfcmx0YWJs
ZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50ICppZHgpCit7CisJc3RydWN0IHB4YTN4eF9iYm0g
KmJibSA9IE5VTEw7CisJdW5zaWduZWQgY2hhciAqdG1wOworCXNpemVfdCByZXRsZW47CisJaW50
IGxlbiwgcGFnZXM7CisKKwlpZiAodmVyaWZ5X2JibV9tYWdpYyhtdGQsICZiYm0pIDwgMCkgewor
CQkvKiBCQk0gZG9uJ3Qgc3VwcG9ydCB0aGlzIHR5cGUgb2YgZmxhc2ggKi8KKwkJcmV0dXJuIC1F
SU5WQUw7CisJfQorCisJcGFnZXMgPSBtdGQtPmVyYXNlc2l6ZSA+PiBiYm0tPnBhZ2Vfc2hpZnQ7
CisJaWYgKCgqaWR4ID49IHBhZ2VzKSB8fCAoKmlkeCA8PSAocGFnZXMgLSBiYm0tPm1heF9zbG90
cykpKSB7CisJCXByaW50ayhLRVJOX0VSUiAiV3JvbmcgU2xvdCBpcyBzcGVjaWZpZWQuXG4iKTsK
KwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJLyogc2hvdWxkIHdyaXRlIHRvIHRoZSBuZXh0IHNs
b3QqLworCSgqaWR4KS0tOworCisJbGVuID0gNDsJCS8qIHRhYmxlIGhlYWRlciAqLworCWxlbiAr
PSBiYm0tPnRhYmxlLT50b3RhbCA8PCAyOworCisJdG1wID0gKHVuc2lnbmVkIGNoYXIgKiliYm0t
PmRhdGFfYnVmOworCW10ZC0+d3JpdGUobXRkLCAoKmlkeCkgPDwgYmJtLT5wYWdlX3NoaWZ0LAor
CQkgICAxIDw8IGJibS0+cGFnZV9zaGlmdCwgJnJldGxlbiwgdG1wKTsKKworCXJldHVybiAwOwor
fQorCitzdGF0aWMgaW50IHB4YTN4eF9zY2FuX3JsdGFibGUoc3RydWN0IG10ZF9pbmZvICptdGQp
Cit7CisJc3RydWN0IHB4YTN4eF9iYm0gKmJibSA9IE5VTEw7CisJc3RydWN0IHJlbG9jYXRlX3Rh
YmxlICp0YWJsZTsKKwlpbnQgcGFnZSwgbWF4X3BhZ2U7CisJc2l6ZV90IHJldGxlbjsKKwlpbnQg
cmV0LCByZXRyeV9jb3VudCA9IDM7CisKKwlpZiAodmVyaWZ5X2JibV9tYWdpYyhtdGQsICZiYm0p
IDwgMCkgeworCQkvKiBCQk0gZG9uJ3Qgc3VwcG9ydCB0aGlzIHR5cGUgb2YgZmxhc2ggKi8KKwkJ
cmV0dXJuIC1FSU5WQUw7CisJfQorCisJcHhhM3h4X2luaXRfcmx0YWJsZShtdGQpOworCisJdGFi
bGUgPSBiYm0tPnRhYmxlOworCisJYmJtLT5jdXJyZW50X3Nsb3QgPSAtMTsKKwlwYWdlID0gKG10
ZC0+ZXJhc2VzaXplID4+IGJibS0+cGFnZV9zaGlmdCkgLSBiYm0tPm1heF9zbG90czsKKwltYXhf
cGFnZSA9IG10ZC0+ZXJhc2VzaXplID4+IGJibS0+cGFnZV9zaGlmdDsKKwlmb3IgKDsgcGFnZSA8
IG1heF9wYWdlOyBwYWdlKyssIHJldHJ5X2NvdW50ID0gMykgeworcmV0cnk6CisJCW1lbXNldChi
Ym0tPmRhdGFfYnVmLCAwLCBtdGQtPndyaXRlc2l6ZSArIG10ZC0+b29ic2l6ZSk7CisJCXJldCA9
IG10ZC0+cmVhZChtdGQsIChwYWdlIDw8IGJibS0+cGFnZV9zaGlmdCksCisJCQkJbXRkLT53cml0
ZXNpemUsICZyZXRsZW4sIGJibS0+ZGF0YV9idWYpOworCQlpZiAocmV0ID09IDApIHsKKwkJCWlm
ICh0YWJsZS0+aGVhZGVyID09IFBYQV9STFRBQkxFX0hFQURFUikgeworCQkJCWJibS0+Y3VycmVu
dF9zbG90ID0gcGFnZTsKKwkJCQlicmVhazsKKwkJCX0KKwkJfSBlbHNlIHsKKwkJCWlmIChyZXRy
eV9jb3VudC0tKQorCQkJCWdvdG8gcmV0cnk7CisJCX0KKwl9CisJaWYgKGJibS0+Y3VycmVudF9z
bG90ICE9IC0xKSB7CisJCXByX2RlYnVnKCJGb3VuZCByZWxvY2F0aW9uIHRhYmxlIGF0IHBhZ2U6
JWRcbiIsCisJCQliYm0tPmN1cnJlbnRfc2xvdCk7CisJCWR1bXBfcmx0YWJsZShiYm0pOworCX0g
ZWxzZSB7CisJCXByX2VycigiQ2FuJ3QgcmVjb2duaXplIHJlbG9jYXRpb24gdGFibGUuXG4iKTsK
KwkJcHJfZXJyKCJDQVVUSU9OOiBJdCBtYXkgY2F1c2UgdW5wcmVkaWNhdGVkIGVycm9yXG4iKTsK
KwkJcHJfZXJyKCJQbGVhc2UgcmUtaW5pdGlhbGl6ZSB0aGUgZmxhc2guXG4iKTsKKwkJbWVtc2V0
KCh1bnNpZ25lZCBjaGFyICopYmJtLT50YWJsZSwgMCwKKwkJCXNpemVvZihzdHJ1Y3QgcmVsb2Nh
dGVfdGFibGUpKTsKKwkJcmV0dXJuIC1FRkFVTFQ7CisJfQorCXJldHVybiAwOworfQorCisvKgor
ICogRmluZCB0aGUgcmVsb2NhdGVkIGJsb2NrIG9mIHRoZSBiYWQgb25lLgorICogSWYgaXQncyBh
IGdvb2QgYmxvY2ssIHJldHVybiAwLiBPdGhlcndpc2UsIHJldHVybiBhIHJlbG9jYXRlZCBvbmUu
CisgKiBpZHggcG9pbnRzIHRvIHRoZSBuZXh0IHJlbG9jYXRpb24gZW50cnkKKyAqIElmIHRoZSBy
ZWxvY2F0ZWQgYmxvY2sgaXMgYmFkLCBhbiBuZXcgZW50cnkgd2lsbCBiZSBhZGRlZCBpbnRvIHRo
ZQorICogYm90dG9tIG9mIHRoZSByZWxvY2F0aW9uIHRhYmxlLgorICovCitzdGF0aWMgbG9mZl90
IHB4YTN4eF9zZWFyY2hfcmxlbnRyeShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcykK
K3sKKwlzdHJ1Y3QgcHhhM3h4X2JibSAqYmJtID0gTlVMTDsKKwlzdHJ1Y3QgcmVsb2NhdGVfdGFi
bGUgKnRhYmxlID0gTlVMTDsKKwlzdHJ1Y3QgcmVsb2NhdGVfZW50cnkgKmVudHJ5ID0gTlVMTDsK
KwlpbnQgaSwgYmxvY2s7CisKKwkvKgorCSAqIEluIFNMQywgYmxvY2sgMCBzaG91bGRuJ3QgYmUg
YnJva2VuLgorCSAqIEluIHNvbWUgY29tbWFuZCwgYWRkcmVzcyBpcyBhc3NpZ25lZCB0byAwIGlm
IGl0IGRvZXNuJ3QgbmVlZAorCSAqIHRvIG9wZXJhdGUgYWRkcmVzcy4gU28ganVzdCBza2lwIGl0
LgorCSAqLworCWlmIChvZnMgPD0gMCkKKwkJcmV0dXJuIG9mczsKKworCWlmICh2ZXJpZnlfYmJt
X21hZ2ljKG10ZCwgJmJibSkgPCAwKQorCQlyZXR1cm4gb2ZzOworCisJdGFibGUgPSBiYm0tPnRh
YmxlOworCWVudHJ5ID0gYmJtLT5lbnRyeTsKKworCWJsb2NrID0gb2ZzID4+IGJibS0+ZXJhc2Vf
c2hpZnQ7CisKKwlpZiAoKGJibS0+Y3VycmVudF9zbG90ID09IC0xKSB8fCAodGFibGUtPnRvdGFs
IDw9IDApCisJCXx8IChibG9jayA+PSAobXRkLT5zaXplID4+IGJibS0+ZXJhc2Vfc2hpZnQpKSkK
KwkJcmV0dXJuIG9mczsKKworCW9mcyA9IG9mcyAtIChibG9jayA8PCBiYm0tPmVyYXNlX3NoaWZ0
KTsJLyogc2F2ZSBvZmZzZXQgKi8KKworCWZvciAoaSA9IDA7IGkgPCB0YWJsZS0+dG90YWw7IGkr
KykgeworCQlpZiAoYmxvY2sgPT0gZW50cnlbaV0uZnJvbSkgeworCQkJYmxvY2sgPSBlbnRyeVtp
XS50bzsKKwkJCWJyZWFrOworCQl9CisJfQorCW9mcyArPSBibG9jayA8PCBiYm0tPmVyYXNlX3No
aWZ0OworCXJldHVybiBvZnM7Cit9CisKK3N0YXRpYyBpbnQgcHhhM3h4X21hcmtfcmxlbnRyeShz
dHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IGJsb2NrKQoreworCXN0cnVjdCBweGEzeHhfYmJtICpi
Ym0gPSBOVUxMOworCWludCByZXQgPSAwOworCisJcmV0ID0gdmVyaWZ5X2JibV9tYWdpYyhtdGQs
ICZiYm0pOworCWlmIChyZXQgPCAwKSB7CisJCS8qIEJCTSBkb24ndCBzdXBwb3J0IHRoaXMgdHlw
ZSBvZiBmbGFzaCAqLworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlyZXQgPSB1cGRhdGVfcmx0
YWJsZShtdGQsIGJsb2NrKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJcmV0dXJuIHN5
bmNfcmx0YWJsZShtdGQsICYoYmJtLT5jdXJyZW50X3Nsb3QpKTsKK30KKworLyogSWYgTWFydmVs
bCBCQk0gaXMgdXNlZCwgcmV0dXJuIDAuIE90aGVyd2lzZSwgcmV0dXJuIG5lZ2F0aXZlIHZhbHVl
LiAqLworc3RydWN0IHB4YTN4eF9iYm0gKnB4YTN4eF9xdWVyeV9iYm0odm9pZCkKK3sKKwlpZiAo
cHhhM3h4X2JibSkKKwkJcmV0dXJuIHB4YTN4eF9iYm07CisJcmV0dXJuIE5VTEw7Cit9CitFWFBP
UlRfU1lNQk9MKHB4YTN4eF9xdWVyeV9iYm0pOworCitzdGF0aWMgaW50IF9faW5pdCBweGEzeHhf
YmJtX2luaXQodm9pZCkKK3sKKwlzdHJ1Y3QgcHhhM3h4X2JibSAqYmJtOworCisJYmJtID0ga3ph
bGxvYyhzaXplb2Yoc3RydWN0IHB4YTN4eF9iYm0pLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWJibSkK
KwkJcmV0dXJuIC1FTk9NRU07CisKKwliYm0tPm1hZ2ljCQk9IFBYQV9CQk1fTUFHSUM7CisJYmJt
LT51bmluaXQJCT0gcHhhM3h4X3VuaW5pdF9ybHRhYmxlOworCWJibS0+c2VhcmNoCQk9IHB4YTN4
eF9zZWFyY2hfcmxlbnRyeTsKKwliYm0tPmJsb2NrX21hcmtiYWQJPSBweGEzeHhfbWFya19ybGVu
dHJ5OworCWJibS0+c2Nhbl9iYnQJCT0gcHhhM3h4X3NjYW5fcmx0YWJsZTsKKworCXB4YTN4eF9i
Ym0gPSBiYm07CisKKwlyZXR1cm4gMDsKK30KK3N1YnN5c19pbml0Y2FsbChweGEzeHhfYmJtX2lu
aXQpOworCitzdGF0aWMgdm9pZCBweGEzeHhfYmJtX2V4aXQodm9pZCkKK3sKKwlpZiAocHhhM3h4
X2JibSkgeworCQlrZnJlZShweGEzeHhfYmJtKTsKKwkJcHhhM3h4X2JibSA9IE5VTEw7CisJfQor
fQorbW9kdWxlX2V4aXQocHhhM3h4X2JibV9leGl0KTsKKworTU9EVUxFX0xJQ0VOU0UoIkdQTCIp
OworTU9EVUxFX0RFU0NSSVBUSU9OKCJNYXJ2ZWxsIFBYQTN4eCBCYWQgQmxvY2sgTWFuYWdlbWVu
dCIpOwotLSAKMS41LjYuNQoK
--001517741a149782d2047465a8bf--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] [MTD] [ONENAND] export onenand_command<br><br>Marvell PXA3=
Message-ID: <mailman.22.1253879983.2253.linux-arm-kernel@lists.infradead.org>

xx bad block management will replaces the bad block with good one.<br>The d=
river have to implement custom command function. Export onenand_command()<b=
r>
in order to reuse the command function in onenand_base.c.<br><br>Signed-off=
-by: Haojian Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com">haoji=
an.zhuang at marvell.com</a>&gt;<br>---<br>=A0drivers/mtd/onenand/onenand_base=
.c |=A0=A0=A0 3 ++-<br>
=A0include/linux/mtd/onenand.h=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 2 ++<br>=A02=
 files changed, 4 insertions(+), 1 deletions(-)<br><br>diff --git a/drivers=
/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c<br>index 6=
e82909..8f7c73a 100644<br>
--- a/drivers/mtd/onenand/onenand_base.c<br>+++ b/drivers/mtd/onenand/onena=
nd_base.c<br>@@ -317,7 +317,7 @@ EXPORT_SYMBOL(flexonenand_region);<br>=A0 =
* Send command to OneNAND device. This function is used for middle/large pa=
ge<br>
=A0 * devices (1KB/2KB Bytes per page)<br>=A0 */<br>-static int onenand_com=
mand(struct mtd_info *mtd, int cmd, loff_t addr, size_t len)<br>+int onenan=
d_command(struct mtd_info *mtd, int cmd, loff_t addr, size_t len)<br>=A0{<b=
r>
=A0=A0=A0=A0 struct onenand_chip *this =3D mtd-&gt;priv;<br>=A0=A0=A0=A0 in=
t value, block, page;<br>@@ -433,6 +433,7 @@ static int onenand_command(str=
uct mtd_info *mtd, int cmd, loff_t addr, size_t le<br>=A0<br>=A0=A0=A0=A0 r=
eturn 0;<br>=A0}<br>+EXPORT_SYMBOL(onenand_command);<br>
=A0<br>=A0/**<br>=A0 * onenand_read_ecc - return ecc status<br>diff --git a=
/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h<br>index 8ed8733=
..c99737f 100644<br>--- a/include/linux/mtd/onenand.h<br>+++ b/include/linu=
x/mtd/onenand.h<br>
@@ -24,6 +24,8 @@<br>=A0extern int onenand_scan(struct mtd_info *mtd, int m=
ax_chips);<br>=A0/* Free resources held by the OneNAND device */<br>=A0exte=
rn void onenand_release(struct mtd_info *mtd);<br>+extern int onenand_comma=
nd(struct mtd_info *mtd, int cmd,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 loff_t addr, size_t len);<br>=A0<br>=
=A0/*<br>=A0 * onenand_state_t - chip states<br>-- <br>1.5.6.5<br><br>

--0016e645b8ca818e73047465ae8e--
--0016e645b8ca818e7c047465ae90
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002--MTD-ONENAND-export-onenand_command.patch"
Content-Disposition: attachment; 
	filename="0002--MTD-ONENAND-export-onenand_command.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g01cnbl30

RnJvbSBmMTA0Yzc3OGM0Zjc2ZWJlMWI3ZDRiNDU3NWQ3ZTliMGRmZmM2ZDY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTU6MTU6NTYgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBbTVREXSBbT05FTkFORF0gZXhwb3J0IG9uZW5hbmRfY29tbWFuZAoKTWFydmVsbCBQWEEz
eHggYmFkIGJsb2NrIG1hbmFnZW1lbnQgd2lsbCByZXBsYWNlcyB0aGUgYmFkIGJsb2NrIHdpdGgg
Z29vZCBvbmUuClRoZSBkcml2ZXIgaGF2ZSB0byBpbXBsZW1lbnQgY3VzdG9tIGNvbW1hbmQgZnVu
Y3Rpb24uIEV4cG9ydCBvbmVuYW5kX2NvbW1hbmQoKQppbiBvcmRlciB0byByZXVzZSB0aGUgY29t
bWFuZCBmdW5jdGlvbiBpbiBvbmVuYW5kX2Jhc2UuYy4KClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4g
Wmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL210ZC9vbmVu
YW5kL29uZW5hbmRfYmFzZS5jIHwgICAgMyArKy0KIGluY2x1ZGUvbGludXgvbXRkL29uZW5hbmQu
aCAgICAgICAgfCAgICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9vbmVuYW5kL29uZW5hbmRfYmFz
ZS5jIGIvZHJpdmVycy9tdGQvb25lbmFuZC9vbmVuYW5kX2Jhc2UuYwppbmRleCA2ZTgyOTA5Li44
ZjdjNzNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jCisr
KyBiL2RyaXZlcnMvbXRkL29uZW5hbmQvb25lbmFuZF9iYXNlLmMKQEAgLTMxNyw3ICszMTcsNyBA
QCBFWFBPUlRfU1lNQk9MKGZsZXhvbmVuYW5kX3JlZ2lvbik7CiAgKiBTZW5kIGNvbW1hbmQgdG8g
T25lTkFORCBkZXZpY2UuIFRoaXMgZnVuY3Rpb24gaXMgdXNlZCBmb3IgbWlkZGxlL2xhcmdlIHBh
Z2UKICAqIGRldmljZXMgKDFLQi8yS0IgQnl0ZXMgcGVyIHBhZ2UpCiAgKi8KLXN0YXRpYyBpbnQg
b25lbmFuZF9jb21tYW5kKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgY21kLCBsb2ZmX3QgYWRk
ciwgc2l6ZV90IGxlbikKK2ludCBvbmVuYW5kX2NvbW1hbmQoc3RydWN0IG10ZF9pbmZvICptdGQs
IGludCBjbWQsIGxvZmZfdCBhZGRyLCBzaXplX3QgbGVuKQogewogCXN0cnVjdCBvbmVuYW5kX2No
aXAgKnRoaXMgPSBtdGQtPnByaXY7CiAJaW50IHZhbHVlLCBibG9jaywgcGFnZTsKQEAgLTQzMyw2
ICs0MzMsNyBAQCBzdGF0aWMgaW50IG9uZW5hbmRfY29tbWFuZChzdHJ1Y3QgbXRkX2luZm8gKm10
ZCwgaW50IGNtZCwgbG9mZl90IGFkZHIsIHNpemVfdCBsZQogCiAJcmV0dXJuIDA7CiB9CitFWFBP
UlRfU1lNQk9MKG9uZW5hbmRfY29tbWFuZCk7CiAKIC8qKgogICogb25lbmFuZF9yZWFkX2VjYyAt
IHJldHVybiBlY2Mgc3RhdHVzCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5k
LmggYi9pbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5kLmgKaW5kZXggOGVkODczMy4uYzk5NzM3ZiAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tdGQvb25lbmFuZC5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvbXRkL29uZW5hbmQuaApAQCAtMjQsNiArMjQsOCBAQAogZXh0ZXJuIGludCBvbmVuYW5kX3Nj
YW4oc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBtYXhfY2hpcHMpOwogLyogRnJlZSByZXNvdXJj
ZXMgaGVsZCBieSB0aGUgT25lTkFORCBkZXZpY2UgKi8KIGV4dGVybiB2b2lkIG9uZW5hbmRfcmVs
ZWFzZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCk7CitleHRlcm4gaW50IG9uZW5hbmRfY29tbWFuZChz
dHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IGNtZCwKKwkJCSAgIGxvZmZfdCBhZGRyLCBzaXplX3Qg
bGVuKTsKIAogLyoKICAqIG9uZW5hbmRfc3RhdGVfdCAtIGNoaXAgc3RhdGVzCi0tIAoxLjUuNi41
Cgo=
--0016e645b8ca818e7c047465ae90--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] [MTD] [ONENAND] supports custom bbm<br><br>In onenand driv=
Message-ID: <mailman.26.1253880048.2253.linux-arm-kernel@lists.infradead.org>

er, the default bad block management is embedded. Custom BBM<br>can&#39;t b=
e used. Now make it to support custom BBM.<br><br>Signed-off-by: Haojian Zh=
uang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com">haojian.zhuang at marve=
ll.com</a>&gt;<br>
---<br>=A0drivers/mtd/onenand/onenand_base.c |=A0=A0 23 +++++++++++++++++++=
++++<br>=A01 files changed, 23 insertions(+), 0 deletions(-)<br><br>diff --=
git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base=
.c<br>
index 8f7c73a..cc6bccb 100644<br>--- a/drivers/mtd/onenand/onenand_base.c<b=
r>+++ b/drivers/mtd/onenand/onenand_base.c<br>@@ -2136,6 +2136,29 @@ static=
 int onenand_block_isbad_nolock(struct mtd_info *mtd, loff_t ofs, int allo<=
br>
=A0{<br>=A0=A0=A0=A0 struct onenand_chip *this =3D mtd-&gt;priv;<br>=A0=A0=
=A0=A0 struct bbm_info *bbm =3D this-&gt;bbm;<br>+=A0=A0=A0 struct mtd_oob_=
ops ops;<br>+=A0=A0=A0 unsigned char *buf =3D this-&gt;page_buf;<br>+=A0=A0=
=A0 int ret;<br>+<br>+=A0=A0=A0 if (!bbm) {<br>
+=A0=A0=A0 =A0=A0=A0 ops.mode =3D MTD_OOB_PLACE;<br>+=A0=A0=A0 =A0=A0=A0 op=
s.ooblen =3D 2;<br>+=A0=A0=A0 =A0=A0=A0 ops.oobbuf =3D buf;<br>+=A0=A0=A0 =
=A0=A0=A0 ops.len =3D 0;<br>+=A0=A0=A0 =A0=A0=A0 ops.ooboffs =3D 0;<br>+=A0=
=A0=A0 =A0=A0=A0 ops.retlen =3D 0;<br>+=A0=A0=A0 =A0=A0=A0 ops.oobretlen =
=3D 0;<br>+<br>+=A0=A0=A0 =A0=A0=A0 ofs =3D (ofs &gt;&gt; this-&gt;erase_sh=
ift) &lt;&lt; this-&gt;erase_shift;<br>
+=A0=A0=A0 =A0=A0=A0 ret =3D onenand_read_oob_nolock(mtd, ofs, &amp;ops);<b=
r>+=A0=A0=A0 =A0=A0=A0 if (ret =3D=3D ONENAND_BBT_READ_FATAL_ERROR)<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 return -EIO;<br>+<br>+=A0=A0=A0 =A0=A0=A0 if ((b=
uf[ONENAND_BADBLOCK_POS] &amp; 0x01) =3D=3D 0) {<br>+=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 return -EIO;<br>
+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 =A0=A0=A0 return 0;<br>+=A0=A0=A0 }<br=
>=A0<br>=A0=A0=A0=A0 /* Return info from the table */<br>=A0=A0=A0=A0 retur=
n bbm-&gt;isbad_bbt(mtd, ofs, allowbbt);<br>-- <br>1.5.6.5<br><br>

--0015175ce06877dbdd047465b2b8--
--0015175ce06877dbe4047465b2ba
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0003--MTD-ONENAND-supports-custom-bbm.patch"
Content-Disposition: attachment; 
	filename="0003--MTD-ONENAND-supports-custom-bbm.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g01coo1l0

RnJvbSA4ZTMyZjQ5NDJkYzgzOWZlNzZhYzMzYmM3MGFhNzQwMWRlNDk2YzU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTU6MjE6NTAgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBbTVREXSBbT05FTkFORF0gc3VwcG9ydHMgY3VzdG9tIGJibQoKSW4gb25lbmFuZCBkcml2
ZXIsIHRoZSBkZWZhdWx0IGJhZCBibG9jayBtYW5hZ2VtZW50IGlzIGVtYmVkZGVkLiBDdXN0b20g
QkJNCmNhbid0IGJlIHVzZWQuIE5vdyBtYWtlIGl0IHRvIHN1cHBvcnQgY3VzdG9tIEJCTS4KClNp
Z25lZC1vZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4K
LS0tCiBkcml2ZXJzL210ZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jIHwgICAyMyArKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL29uZW5hbmQvb25lbmFuZF9iYXNlLmMg
Yi9kcml2ZXJzL210ZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jCmluZGV4IDhmN2M3M2EuLmNjNmJj
Y2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbXRkL29uZW5hbmQvb25lbmFuZF9iYXNlLmMKKysrIGIv
ZHJpdmVycy9tdGQvb25lbmFuZC9vbmVuYW5kX2Jhc2UuYwpAQCAtMjEzNiw2ICsyMTM2LDI5IEBA
IHN0YXRpYyBpbnQgb25lbmFuZF9ibG9ja19pc2JhZF9ub2xvY2soc3RydWN0IG10ZF9pbmZvICpt
dGQsIGxvZmZfdCBvZnMsIGludCBhbGxvCiB7CiAJc3RydWN0IG9uZW5hbmRfY2hpcCAqdGhpcyA9
IG10ZC0+cHJpdjsKIAlzdHJ1Y3QgYmJtX2luZm8gKmJibSA9IHRoaXMtPmJibTsKKwlzdHJ1Y3Qg
bXRkX29vYl9vcHMgb3BzOworCXVuc2lnbmVkIGNoYXIgKmJ1ZiA9IHRoaXMtPnBhZ2VfYnVmOwor
CWludCByZXQ7CisKKwlpZiAoIWJibSkgeworCQlvcHMubW9kZSA9IE1URF9PT0JfUExBQ0U7CisJ
CW9wcy5vb2JsZW4gPSAyOworCQlvcHMub29iYnVmID0gYnVmOworCQlvcHMubGVuID0gMDsKKwkJ
b3BzLm9vYm9mZnMgPSAwOworCQlvcHMucmV0bGVuID0gMDsKKwkJb3BzLm9vYnJldGxlbiA9IDA7
CisKKwkJb2ZzID0gKG9mcyA+PiB0aGlzLT5lcmFzZV9zaGlmdCkgPDwgdGhpcy0+ZXJhc2Vfc2hp
ZnQ7CisJCXJldCA9IG9uZW5hbmRfcmVhZF9vb2Jfbm9sb2NrKG10ZCwgb2ZzLCAmb3BzKTsKKwkJ
aWYgKHJldCA9PSBPTkVOQU5EX0JCVF9SRUFEX0ZBVEFMX0VSUk9SKQorCQkJcmV0dXJuIC1FSU87
CisKKwkJaWYgKChidWZbT05FTkFORF9CQURCTE9DS19QT1NdICYgMHgwMSkgPT0gMCkgeworCQkJ
cmV0dXJuIC1FSU87CisJCX0KKwkJcmV0dXJuIDA7CisJfQogCiAJLyogUmV0dXJuIGluZm8gZnJv
bSB0aGUgdGFibGUgKi8KIAlyZXR1cm4gYmJtLT5pc2JhZF9iYnQobXRkLCBvZnMsIGFsbG93YmJ0
KTsKLS0gCjEuNS42LjUKCg==
--0015175ce06877dbe4047465b2ba--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] [MTD] [ONENAND] add pxa3xx onenand<br><br>In order to supp=
Message-ID: <mailman.30.1253880112.2253.linux-arm-kernel@lists.infradead.org>

ort Marvell PXA3xx bad block management, add pxa3xx onenand<br>device drive=
r. Since there&#39;s some specific operation in it.<br><br>Either pxa3xx on=
enand or generic onenand device driver can be supported.<br>
<br>Signed-off-by: Haojian Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marv=
ell.com">haojian.zhuang at marvell.com</a>&gt;<br>---<br>=A0drivers/mtd/onenan=
d/Kconfig=A0 |=A0=A0=A0 7 +<br>=A0drivers/mtd/onenand/Makefile |=A0=A0=A0 1=
 +<br>=A0drivers/mtd/onenand/pxa3xx.c |=A0 248 ++++++++++++++++++++++++++++=
++++++++++++++<br>
=A0drivers/mtd/pxa3xx_bbm.c=A0=A0=A0=A0 |=A0=A0=A0 4 +<br>=A04 files change=
d, 260 insertions(+), 0 deletions(-)<br>=A0create mode 100644 drivers/mtd/o=
nenand/pxa3xx.c<br><br>diff --git a/drivers/mtd/onenand/Kconfig b/drivers/m=
td/onenand/Kconfig<br>
index 79fa79e..d2878ac 100644<br>--- a/drivers/mtd/onenand/Kconfig<br>+++ b=
/drivers/mtd/onenand/Kconfig<br>@@ -34,6 +34,13 @@ config MTD_ONENAND_OMAP2=
<br>=A0=A0=A0=A0 =A0 Support for a OneNAND flash device connected to an OMA=
P2/OMAP3 CPU<br>
=A0=A0=A0=A0 =A0 via the GPMC memory controller.<br>=A0<br>+config MTD_ONEN=
AND_PXA3xx<br>+=A0=A0=A0 tristate &quot;OneNAND on PXA3xx/MMP support&quot;=
<br>+=A0=A0=A0 depends on MTD_ONENAND &amp;&amp; (ARCH_PXA || ARCH_MMP)<br>=
+=A0=A0=A0 help<br>+=A0=A0=A0 =A0 Support for a OneNAND flash device connec=
ted to an PXA3xx CPU<br>
+=A0=A0=A0 =A0 via the static memory controller.<br>+<br>=A0config MTD_ONEN=
AND_OTP<br>=A0=A0=A0=A0 bool &quot;OneNAND OTP Support&quot;<br>=A0=A0=A0=
=A0 select HAVE_MTD_OTP<br>diff --git a/drivers/mtd/onenand/Makefile b/driv=
ers/mtd/onenand/Makefile<br>
index 64b6cc6..66cc1fb 100644<br>--- a/drivers/mtd/onenand/Makefile<br>+++ =
b/drivers/mtd/onenand/Makefile<br>@@ -8,6 +8,7 @@ obj-$(CONFIG_MTD_ONENAND)=
=A0=A0=A0 =A0=A0=A0 +=3D onenand.o<br>=A0# Board specific.<br>=A0obj-$(CONF=
IG_MTD_ONENAND_GENERIC)=A0=A0=A0 +=3D generic.o<br>
=A0obj-$(CONFIG_MTD_ONENAND_OMAP2)=A0=A0=A0 =A0=A0=A0 +=3D omap2.o<br>+obj-=
$(CONFIG_MTD_ONENAND_PXA3xx)=A0=A0=A0 +=3D pxa3xx.o<br>=A0<br>=A0# Simulato=
r<br>=A0obj-$(CONFIG_MTD_ONENAND_SIM)=A0=A0=A0 =A0=A0=A0 +=3D onenand_sim.o=
<br>diff --git a/drivers/mtd/onenand/pxa3xx.c b/drivers/mtd/onenand/pxa3xx.=
c<br>
new file mode 100644<br>index 0000000..d97ec15<br>--- /dev/null<br>+++ b/dr=
ivers/mtd/onenand/pxa3xx.c<br>@@ -0,0 +1,248 @@<br>+/*<br>+ *=A0 linux/driv=
ers/mtd/onenand/onenand_base.c<br>+ *<br>+ *=A0 Copyright (C) 2007 Marvell =
Internal Ltd.<br>
+ *<br>+ *=A0 Haojian Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.c=
om">haojian.zhuang at marvell.com</a>&gt;<br>+ *<br>+ * This program is free s=
oftware; you can redistribute it and/or modify<br>+ * it under the terms of=
 the GNU General Public License version 2 as<br>
+ * published by the Free Software Foundation.<br>+ */<br>+<br>+#include &l=
t;linux/module.h&gt;<br>+#include &lt;linux/init.h&gt;<br>+#include &lt;lin=
ux/platform_device.h&gt;<br>+#include &lt;linux/mtd/mtd.h&gt;<br>+#include =
&lt;linux/mtd/onenand.h&gt;<br>
+#include &lt;linux/mtd/partitions.h&gt;<br>+<br>+#include &lt;asm/io.h&gt;=
<br>+#include &lt;asm/mach/flash.h&gt;<br>+<br>+#ifdef CONFIG_PXA3xx_BBM<br=
>+#include &lt;plat/pxa3xx_bbm.h&gt;<br>+#endif<br>+<br>+#define DRIVER_NAM=
E=A0=A0=A0 &quot;pxa3xx-onenand&quot;<br>
+<br>+<br>+#ifdef CONFIG_MTD_PARTITIONS<br>+static const char *part_probes[=
] =3D { &quot;cmdlinepart&quot;, NULL,=A0 };<br>+#endif<br>+<br>+struct pxa=
3xx_onenand_info {<br>+=A0=A0=A0 struct onenand_chip=A0=A0=A0 onenand;<br>+=
#ifdef CONFIG_PXA3xx_BBM<br>
+=A0=A0=A0 /*<br>+=A0=A0=A0 =A0* Restriction: onenand_chip should be the fi=
rst one of<br>+=A0=A0=A0 =A0* pxa3xx_onenand_info.<br>+=A0=A0=A0 =A0* bbm s=
hould be the second one of pxa3xx_nand_info.<br>+=A0=A0=A0 =A0* Marvell PXA=
3xx BBM always access this field to get bbm.<br>
+=A0=A0=A0 =A0*/<br>+=A0=A0=A0 struct pxa3xx_bbm=A0=A0=A0 *bbm;<br>+#endif<=
br>+=A0=A0=A0 struct mtd_info=A0=A0=A0 =A0=A0=A0 mtd;<br>+=A0=A0=A0 struct =
mtd_partition=A0=A0=A0 *parts;<br>+};<br>+<br>+#ifdef CONFIG_PXA3xx_BBM<br>=
+static int pxa3xx_onenand_block_markbad(struct mtd_info *mtd, loff_t ofs)<=
br>
+{<br>+=A0=A0=A0 struct pxa3xx_onenand_info *info =3D mtd-&gt;priv;<br>+=A0=
=A0=A0 struct pxa3xx_bbm *bbm =3D info-&gt;bbm;<br>+=A0=A0=A0 struct onenan=
d_chip *this =3D mtd-&gt;priv;<br>+=A0=A0=A0 unsigned char buf[2] =3D {0, 0=
};<br>+=A0=A0=A0 struct mtd_oob_ops ops =3D {<br>
+=A0=A0=A0 =A0=A0=A0 .mode =3D MTD_OOB_PLACE,<br>+=A0=A0=A0 =A0=A0=A0 .oobl=
en =3D 2,<br>+=A0=A0=A0 =A0=A0=A0 .oobbuf =3D buf,<br>+=A0=A0=A0 =A0=A0=A0 =
.ooboffs =3D 0,<br>+=A0=A0=A0 };<br>+=A0=A0=A0 int block, ret;<br>+<br>+=A0=
=A0=A0 /* Get block number */<br>+=A0=A0=A0 block =3D onenand_block(this, o=
fs);<br>
+<br>+=A0=A0=A0=A0=A0=A0=A0 /* We write two bytes, so we dont have to mess =
with 16 bit access */<br>+=A0=A0=A0=A0=A0=A0=A0 ofs +=3D mtd-&gt;oobsize + =
(ONENAND_BADBLOCK_POS &amp; ~0x01);<br>+=A0=A0=A0 /* FIXME : What to do whe=
n marking SLC block in partition<br>
+=A0=A0=A0 =A0* =A0=A0=A0 =A0=A0 with MLC erasesize? For now, it is not adv=
isable to<br>+=A0=A0=A0 =A0*=A0=A0=A0 =A0=A0 create partitions containing b=
oth SLC and MLC regions.<br>+=A0=A0=A0 =A0*/<br>+=A0=A0=A0 ret =3D mtd-&gt;=
write_oob(mtd, ofs, &amp;ops);<br>+=A0=A0=A0 if (ret)<br>
+=A0=A0=A0 =A0=A0=A0 return ret;<br>+<br>+=A0=A0=A0 return bbm-&gt;block_ma=
rkbad(mtd, block);<br>+}<br>+<br>+int verify_onenand_bbm(struct mtd_info *m=
td, struct pxa3xx_bbm **bbm)<br>+{<br>+=A0=A0=A0 struct onenand_chip *chip =
=3D mtd-&gt;priv;<br>+=A0=A0=A0 struct pxa3xx_bbm **nbbm =3D NULL;<br>
+<br>+=A0=A0=A0 /* check whether current flash is onenand */<br>+=A0=A0=A0 =
nbbm =3D (struct pxa3xx_bbm **)(++chip);<br>+=A0=A0=A0 if (((unsigned int)n=
bbm &lt; PAGE_OFFSET)<br>+=A0=A0=A0 =A0=A0=A0 || ((unsigned int)*nbbm &lt; =
PAGE_OFFSET))<br>+=A0=A0=A0 =A0=A0=A0 return PXA3xx_BBM_INVALID;<br>
+<br>+=A0=A0=A0 if ((*nbbm)-&gt;magic =3D=3D PXA_BBM_MAGIC) {<br>+=A0=A0=A0=
 =A0=A0=A0 pr_debug(&quot;%s:Found Onenand flash.\n&quot;, __func__);<br>+=
=A0=A0=A0 =A0=A0=A0 *bbm =3D *nbbm;<br>+=A0=A0=A0 =A0=A0=A0 return PXA3xx_B=
BM_ONENAND;<br>+=A0=A0=A0 }<br>+=A0=A0=A0 return PXA3xx_BBM_INVALID;<br>
+}<br>+<br>+/**<br>+ * pxa3xx_onenand_command - Send command to OneNAND dev=
ice<br>+ * @param mtd=A0=A0=A0 =A0=A0=A0 MTD device structure<br>+ * @param=
 cmd=A0=A0=A0 =A0=A0=A0 the command to be sent<br>+ * @param addr=A0=A0=A0 =
=A0=A0=A0 offset to read from or write to<br>
+ * @param len=A0=A0=A0 =A0=A0=A0 number of bytes to read or write<br>+ *<b=
r>+ * Send command to OneNAND device. This function is used for middle/larg=
e page<br>+ * devices (1KB/2KB Bytes per page)<br>+ */<br>+static int pxa3x=
x_onenand_command(struct mtd_info *mtd, int cmd,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 loff_t addr, size_t len)<br>+{=
<br>+=A0=A0=A0 struct pxa3xx_onenand_info *info =3D mtd-&gt;priv;<br>+=A0=
=A0=A0 struct pxa3xx_bbm *bbm =3D info-&gt;bbm;<br>+<br>+=A0=A0=A0 /* Get r=
eolocated address */<br>+=A0=A0=A0 addr =3D bbm-&gt;search(mtd, addr);<br>
+=A0=A0=A0 return onenand_command(mtd, cmd, addr, len);<br>+}<br>+<br>+stat=
ic void pxa3xx_onenand_init_chip(struct pxa3xx_onenand_info *info)<br>+{<br=
>+=A0=A0=A0 struct onenand_chip *this =3D &amp;info-&gt;onenand;<br>+=A0=A0=
=A0 struct pxa3xx_bbm *bbm =3D NULL;<br>
+<br>+=A0=A0=A0 bbm =3D pxa3xx_query_bbm();<br>+=A0=A0=A0 if (bbm) {<br>+=
=A0=A0=A0 =A0=A0=A0 /* Marvell PXA3xx BBM is initialized successfully */<br=
>+=A0=A0=A0 =A0=A0=A0 info-&gt;bbm =3D bbm;<br>+=A0=A0=A0 =A0=A0=A0 this-&g=
t;scan_bbt =3D bbm-&gt;scan_bbt;<br>+=A0=A0=A0 =A0=A0=A0 this-&gt;block_mar=
kbad =3D pxa3xx_onenand_block_markbad;<br>
+=A0=A0=A0 =A0=A0=A0 this-&gt;command =3D pxa3xx_onenand_command;<br>+=A0=
=A0=A0 }<br>+}<br>+#else<br>+static void pxa3xx_onenand_init_chip(struct px=
a3xx_onenand_info *info) {}<br>+#endif<br>+<br>+static int __devinit pxa3xx=
_onenand_probe(struct platform_device *pdev)<br>
+{<br>+=A0=A0=A0 struct pxa3xx_onenand_info *info =3D NULL;<br>+=A0=A0=A0 s=
truct flash_platform_data *pdata =3D pdev-&gt;dev.platform_data;<br>+=A0=A0=
=A0 struct resource *res =3D pdev-&gt;resource;<br>+=A0=A0=A0 unsigned long=
 size =3D res-&gt;end - res-&gt;start + 1;<br>
+=A0=A0=A0 int err;<br>+<br>+=A0=A0=A0 info =3D kzalloc(sizeof(struct pxa3x=
x_onenand_info), GFP_KERNEL);<br>+=A0=A0=A0 if (!info)<br>+=A0=A0=A0 =A0=A0=
=A0 return -ENOMEM;<br>+<br>+=A0=A0=A0 if (!request_mem_region(res-&gt;star=
t, size, pdev-&gt;dev.driver-&gt;name)) {<br>
+=A0=A0=A0 =A0=A0=A0 err =3D -EBUSY;<br>+=A0=A0=A0 =A0=A0=A0 goto out_free_=
info;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 info-&gt;onenand.base =3D ioremap(=
res-&gt;start, size);<br>+=A0=A0=A0 if (!info-&gt;onenand.base) {<br>+=A0=
=A0=A0 =A0=A0=A0 err =3D -ENOMEM;<br>+=A0=A0=A0 =A0=A0=A0 goto out_release_=
mem_region;<br>
+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 info-&gt;onenand.mmcontrol =3D pdata-&gt;mm=
control;<br>+=A0=A0=A0 info-&gt;onenand.irq =3D platform_get_irq(pdev, 0);<=
br>+<br>+=A0=A0=A0 pxa3xx_onenand_init_chip(info);<br>+<br>+=A0=A0=A0 info-=
&gt;<a href=3D"http://mtd.name">mtd.name</a> =3D dev_name(&amp;pdev-&gt;dev=
);<br>
+=A0=A0=A0 info-&gt;mtd.priv =3D &amp;info-&gt;onenand;<br>+=A0=A0=A0 info-=
&gt;mtd.owner =3D THIS_MODULE;<br>+<br>+=A0=A0=A0 if (onenand_scan(&amp;inf=
o-&gt;mtd, 1)) {<br>+=A0=A0=A0 =A0=A0=A0 err =3D -ENXIO;<br>+=A0=A0=A0 =A0=
=A0=A0 goto out_iounmap;<br>+=A0=A0=A0 }<br>+<br>+#ifdef CONFIG_MTD_PARTITI=
ONS<br>
+=A0=A0=A0 err =3D parse_mtd_partitions(&amp;info-&gt;mtd, part_probes, &am=
p;info-&gt;parts, 0);<br>+=A0=A0=A0 if (err &gt; 0)<br>+=A0=A0=A0 =A0=A0=A0=
 add_mtd_partitions(&amp;info-&gt;mtd, info-&gt;parts, err);<br>+=A0=A0=A0 =
else if (err &lt;=3D 0 &amp;&amp; pdata-&gt;parts)<br>
+=A0=A0=A0 =A0=A0=A0 add_mtd_partitions(&amp;info-&gt;mtd, pdata-&gt;parts,=
 pdata-&gt;nr_parts);<br>+=A0=A0=A0 else<br>+#endif<br>+=A0=A0=A0 =A0=A0=A0=
 err =3D add_mtd_device(&amp;info-&gt;mtd);<br>+<br>+=A0=A0=A0 platform_set=
_drvdata(pdev, info);<br>+<br>+=A0=A0=A0 return 0;<br>
+<br>+out_iounmap:<br>+=A0=A0=A0 iounmap(info-&gt;onenand.base);<br>+out_re=
lease_mem_region:<br>+=A0=A0=A0 release_mem_region(res-&gt;start, size);<br=
>+out_free_info:<br>+=A0=A0=A0 kfree(info);<br>+<br>+=A0=A0=A0 return err;<=
br>+}<br>+<br>+static int __devexit pxa3xx_onenand_remove(struct platform_d=
evice *pdev)<br>
+{<br>+=A0=A0=A0 struct pxa3xx_onenand_info *info =3D platform_get_drvdata(=
pdev);<br>+=A0=A0=A0 struct resource *res =3D pdev-&gt;resource;<br>+=A0=A0=
=A0 unsigned long size =3D res-&gt;end - res-&gt;start + 1;<br>+<br>+=A0=A0=
=A0 platform_set_drvdata(pdev, NULL);<br>
+<br>+=A0=A0=A0 if (info) {<br>+=A0=A0=A0 =A0=A0=A0 if (info-&gt;parts)<br>=
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 del_mtd_partitions(&amp;info-&gt;mtd);<br>+=
=A0=A0=A0 =A0=A0=A0 else<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 del_mtd_device(&=
amp;info-&gt;mtd);<br>+<br>+=A0=A0=A0 =A0=A0=A0 onenand_release(&amp;info-&=
gt;mtd);<br>
+=A0=A0=A0 =A0=A0=A0 release_mem_region(res-&gt;start, size);<br>+=A0=A0=A0=
 =A0=A0=A0 iounmap(info-&gt;onenand.base);<br>+=A0=A0=A0 =A0=A0=A0 kfree(in=
fo);<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 return 0;<br>+}<br>+<br>+static str=
uct platform_driver pxa3xx_onenand_driver =3D {<br>
+=A0=A0=A0 .driver =3D {<br>+=A0=A0=A0 =A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =
=3D DRIVER_NAME,<br>+=A0=A0=A0 =A0=A0=A0 .owner=A0=A0=A0 =A0=A0=A0 =3D THIS=
_MODULE,<br>+=A0=A0=A0 },<br>+=A0=A0=A0 .probe=A0=A0=A0 =A0=A0=A0 =3D pxa3x=
x_onenand_probe,<br>+=A0=A0=A0 .remove=A0=A0=A0 =A0=A0=A0 =3D __devexit_p(p=
xa3xx_onenand_remove),<br>+};<br>
+<br>+MODULE_ALIAS(DRIVER_NAME);<br>+<br>+static int __init pxa3xx_onenand_=
init(void)<br>+{<br>+=A0=A0=A0 return platform_driver_register(&amp;pxa3xx_=
onenand_driver);<br>+}<br>+<br>+static void __exit pxa3xx_onenand_exit(void=
)<br>
+{<br>+=A0=A0=A0 platform_driver_unregister(&amp;pxa3xx_onenand_driver);<br=
>+}<br>+<br>+module_init(pxa3xx_onenand_init);<br>+module_exit(pxa3xx_onena=
nd_exit);<br>+<br>+MODULE_LICENSE(&quot;GPL&quot;);<br>+MODULE_AUTHOR(&quot=
;Haojian Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com">haojian.z=
huang at marvell.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;Glue layer for OneNAND flash on Marvell PXA3xx&qu=
ot;);<br>diff --git a/drivers/mtd/pxa3xx_bbm.c b/drivers/mtd/pxa3xx_bbm.c<b=
r>index bcc9a35..070e5d1 100644<br>--- a/drivers/mtd/pxa3xx_bbm.c<br>+++ b/=
drivers/mtd/pxa3xx_bbm.c<br>
@@ -27,6 +27,10 @@ static int verify_bbm_magic(struct mtd_info *mtd, struct=
 pxa3xx_bbm **bbm)<br>=A0=A0=A0=A0 int ret;<br>=A0<br>=A0=A0=A0=A0 ret =3D =
verify_nand_bbm(mtd, bbm);<br>+=A0=A0=A0 if (ret &gt;=3D 0)<br>+=A0=A0=A0 =
=A0=A0=A0 return ret;<br>+<br>+=A0=A0=A0 ret =3D verify_onenand_bbm(mtd, bb=
m);<br>
=A0=A0=A0=A0 return ret;<br>=A0}<br>=A0<br>-- <br>1.5.6.5<br><br>

--0016e644c18e3e1667047465b6ab--
--0016e644c18e3e1679047465b6ad
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0004--MTD-ONENAND-add-pxa3xx-onenand.patch"
Content-Disposition: attachment; 
	filename="0004--MTD-ONENAND-add-pxa3xx-onenand.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g01cq8fx0

RnJvbSA3M2Y2ODZhMDBiYTRlZmVlNjJhZDYxZTNiNjViMzM3OTM5ZGIwMzhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTU6MjU6MDMgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBbTVREXSBbT05FTkFORF0gYWRkIHB4YTN4eCBvbmVuYW5kCgpJbiBvcmRlciB0byBzdXBw
b3J0IE1hcnZlbGwgUFhBM3h4IGJhZCBibG9jayBtYW5hZ2VtZW50LCBhZGQgcHhhM3h4IG9uZW5h
bmQKZGV2aWNlIGRyaXZlci4gU2luY2UgdGhlcmUncyBzb21lIHNwZWNpZmljIG9wZXJhdGlvbiBp
biBpdC4KCkVpdGhlciBweGEzeHggb25lbmFuZCBvciBnZW5lcmljIG9uZW5hbmQgZGV2aWNlIGRy
aXZlciBjYW4gYmUgc3VwcG9ydGVkLgoKU2lnbmVkLW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhh
b2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbXRkL29uZW5hbmQvS2NvbmZp
ZyAgfCAgICA3ICsKIGRyaXZlcnMvbXRkL29uZW5hbmQvTWFrZWZpbGUgfCAgICAxICsKIGRyaXZl
cnMvbXRkL29uZW5hbmQvcHhhM3h4LmMgfCAgMjQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogZHJpdmVycy9tdGQvcHhhM3h4X2JibS5jICAgICB8ICAgIDQgKwog
NCBmaWxlcyBjaGFuZ2VkLCAyNjAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC9vbmVuYW5kL3B4YTN4eC5jCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tdGQvb25lbmFuZC9LY29uZmlnIGIvZHJpdmVycy9tdGQvb25lbmFuZC9LY29uZmln
CmluZGV4IDc5ZmE3OWUuLmQyODc4YWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbXRkL29uZW5hbmQv
S2NvbmZpZworKysgYi9kcml2ZXJzL210ZC9vbmVuYW5kL0tjb25maWcKQEAgLTM0LDYgKzM0LDEz
IEBAIGNvbmZpZyBNVERfT05FTkFORF9PTUFQMgogCSAgU3VwcG9ydCBmb3IgYSBPbmVOQU5EIGZs
YXNoIGRldmljZSBjb25uZWN0ZWQgdG8gYW4gT01BUDIvT01BUDMgQ1BVCiAJICB2aWEgdGhlIEdQ
TUMgbWVtb3J5IGNvbnRyb2xsZXIuCiAKK2NvbmZpZyBNVERfT05FTkFORF9QWEEzeHgKKwl0cmlz
dGF0ZSAiT25lTkFORCBvbiBQWEEzeHgvTU1QIHN1cHBvcnQiCisJZGVwZW5kcyBvbiBNVERfT05F
TkFORCAmJiAoQVJDSF9QWEEgfHwgQVJDSF9NTVApCisJaGVscAorCSAgU3VwcG9ydCBmb3IgYSBP
bmVOQU5EIGZsYXNoIGRldmljZSBjb25uZWN0ZWQgdG8gYW4gUFhBM3h4IENQVQorCSAgdmlhIHRo
ZSBzdGF0aWMgbWVtb3J5IGNvbnRyb2xsZXIuCisKIGNvbmZpZyBNVERfT05FTkFORF9PVFAKIAli
b29sICJPbmVOQU5EIE9UUCBTdXBwb3J0IgogCXNlbGVjdCBIQVZFX01URF9PVFAKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL29uZW5hbmQvTWFrZWZpbGUgYi9kcml2ZXJzL210ZC9vbmVuYW5kL01h
a2VmaWxlCmluZGV4IDY0YjZjYzYuLjY2Y2MxZmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbXRkL29u
ZW5hbmQvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9tdGQvb25lbmFuZC9NYWtlZmlsZQpAQCAtOCw2
ICs4LDcgQEAgb2JqLSQoQ09ORklHX01URF9PTkVOQU5EKQkJKz0gb25lbmFuZC5vCiAjIEJvYXJk
IHNwZWNpZmljLgogb2JqLSQoQ09ORklHX01URF9PTkVOQU5EX0dFTkVSSUMpCSs9IGdlbmVyaWMu
bwogb2JqLSQoQ09ORklHX01URF9PTkVOQU5EX09NQVAyKQkJKz0gb21hcDIubworb2JqLSQoQ09O
RklHX01URF9PTkVOQU5EX1BYQTN4eCkJKz0gcHhhM3h4Lm8KIAogIyBTaW11bGF0b3IKIG9iai0k
KENPTkZJR19NVERfT05FTkFORF9TSU0pCQkrPSBvbmVuYW5kX3NpbS5vCmRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9vbmVuYW5kL3B4YTN4eC5jIGIvZHJpdmVycy9tdGQvb25lbmFuZC9weGEzeHgu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5kOTdlYzE1Ci0tLSAvZGV2L251
bGwKKysrIGIvZHJpdmVycy9tdGQvb25lbmFuZC9weGEzeHguYwpAQCAtMCwwICsxLDI0OCBAQAor
LyoKKyAqICBsaW51eC9kcml2ZXJzL210ZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jCisgKgorICog
IENvcHlyaWdodCAoQykgMjAwNyBNYXJ2ZWxsIEludGVybmFsIEx0ZC4KKyAqCisgKiAgSGFvamlh
biBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2lu
aXQuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51
eC9tdGQvbXRkLmg+CisjaW5jbHVkZSA8bGludXgvbXRkL29uZW5hbmQuaD4KKyNpbmNsdWRlIDxs
aW51eC9tdGQvcGFydGl0aW9ucy5oPgorCisjaW5jbHVkZSA8YXNtL2lvLmg+CisjaW5jbHVkZSA8
YXNtL21hY2gvZmxhc2guaD4KKworI2lmZGVmIENPTkZJR19QWEEzeHhfQkJNCisjaW5jbHVkZSA8
cGxhdC9weGEzeHhfYmJtLmg+CisjZW5kaWYKKworI2RlZmluZSBEUklWRVJfTkFNRQkicHhhM3h4
LW9uZW5hbmQiCisKKworI2lmZGVmIENPTkZJR19NVERfUEFSVElUSU9OUworc3RhdGljIGNvbnN0
IGNoYXIgKnBhcnRfcHJvYmVzW10gPSB7ICJjbWRsaW5lcGFydCIsIE5VTEwsICB9OworI2VuZGlm
CisKK3N0cnVjdCBweGEzeHhfb25lbmFuZF9pbmZvIHsKKwlzdHJ1Y3Qgb25lbmFuZF9jaGlwCW9u
ZW5hbmQ7CisjaWZkZWYgQ09ORklHX1BYQTN4eF9CQk0KKwkvKgorCSAqIFJlc3RyaWN0aW9uOiBv
bmVuYW5kX2NoaXAgc2hvdWxkIGJlIHRoZSBmaXJzdCBvbmUgb2YKKwkgKiBweGEzeHhfb25lbmFu
ZF9pbmZvLgorCSAqIGJibSBzaG91bGQgYmUgdGhlIHNlY29uZCBvbmUgb2YgcHhhM3h4X25hbmRf
aW5mby4KKwkgKiBNYXJ2ZWxsIFBYQTN4eCBCQk0gYWx3YXlzIGFjY2VzcyB0aGlzIGZpZWxkIHRv
IGdldCBiYm0uCisJICovCisJc3RydWN0IHB4YTN4eF9iYm0JKmJibTsKKyNlbmRpZgorCXN0cnVj
dCBtdGRfaW5mbwkJbXRkOworCXN0cnVjdCBtdGRfcGFydGl0aW9uCSpwYXJ0czsKK307CisKKyNp
ZmRlZiBDT05GSUdfUFhBM3h4X0JCTQorc3RhdGljIGludCBweGEzeHhfb25lbmFuZF9ibG9ja19t
YXJrYmFkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzKQoreworCXN0cnVjdCBweGEz
eHhfb25lbmFuZF9pbmZvICppbmZvID0gbXRkLT5wcml2OworCXN0cnVjdCBweGEzeHhfYmJtICpi
Ym0gPSBpbmZvLT5iYm07CisJc3RydWN0IG9uZW5hbmRfY2hpcCAqdGhpcyA9IG10ZC0+cHJpdjsK
Kwl1bnNpZ25lZCBjaGFyIGJ1ZlsyXSA9IHswLCAwfTsKKwlzdHJ1Y3QgbXRkX29vYl9vcHMgb3Bz
ID0geworCQkubW9kZSA9IE1URF9PT0JfUExBQ0UsCisJCS5vb2JsZW4gPSAyLAorCQkub29iYnVm
ID0gYnVmLAorCQkub29ib2ZmcyA9IDAsCisJfTsKKwlpbnQgYmxvY2ssIHJldDsKKworCS8qIEdl
dCBibG9jayBudW1iZXIgKi8KKwlibG9jayA9IG9uZW5hbmRfYmxvY2sodGhpcywgb2ZzKTsKKwor
ICAgICAgICAvKiBXZSB3cml0ZSB0d28gYnl0ZXMsIHNvIHdlIGRvbnQgaGF2ZSB0byBtZXNzIHdp
dGggMTYgYml0IGFjY2VzcyAqLworICAgICAgICBvZnMgKz0gbXRkLT5vb2JzaXplICsgKE9ORU5B
TkRfQkFEQkxPQ0tfUE9TICYgfjB4MDEpOworCS8qIEZJWE1FIDogV2hhdCB0byBkbyB3aGVuIG1h
cmtpbmcgU0xDIGJsb2NrIGluIHBhcnRpdGlvbgorCSAqIAkgICB3aXRoIE1MQyBlcmFzZXNpemU/
IEZvciBub3csIGl0IGlzIG5vdCBhZHZpc2FibGUgdG8KKwkgKgkgICBjcmVhdGUgcGFydGl0aW9u
cyBjb250YWluaW5nIGJvdGggU0xDIGFuZCBNTEMgcmVnaW9ucy4KKwkgKi8KKwlyZXQgPSBtdGQt
PndyaXRlX29vYihtdGQsIG9mcywgJm9wcyk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CXJldHVybiBiYm0tPmJsb2NrX21hcmtiYWQobXRkLCBibG9jayk7Cit9CisKK2ludCB2ZXJpZnlf
b25lbmFuZF9iYm0oc3RydWN0IG10ZF9pbmZvICptdGQsIHN0cnVjdCBweGEzeHhfYmJtICoqYmJt
KQoreworCXN0cnVjdCBvbmVuYW5kX2NoaXAgKmNoaXAgPSBtdGQtPnByaXY7CisJc3RydWN0IHB4
YTN4eF9iYm0gKipuYmJtID0gTlVMTDsKKworCS8qIGNoZWNrIHdoZXRoZXIgY3VycmVudCBmbGFz
aCBpcyBvbmVuYW5kICovCisJbmJibSA9IChzdHJ1Y3QgcHhhM3h4X2JibSAqKikoKytjaGlwKTsK
KwlpZiAoKCh1bnNpZ25lZCBpbnQpbmJibSA8IFBBR0VfT0ZGU0VUKQorCQl8fCAoKHVuc2lnbmVk
IGludCkqbmJibSA8IFBBR0VfT0ZGU0VUKSkKKwkJcmV0dXJuIFBYQTN4eF9CQk1fSU5WQUxJRDsK
KworCWlmICgoKm5iYm0pLT5tYWdpYyA9PSBQWEFfQkJNX01BR0lDKSB7CisJCXByX2RlYnVnKCIl
czpGb3VuZCBPbmVuYW5kIGZsYXNoLlxuIiwgX19mdW5jX18pOworCQkqYmJtID0gKm5iYm07CisJ
CXJldHVybiBQWEEzeHhfQkJNX09ORU5BTkQ7CisJfQorCXJldHVybiBQWEEzeHhfQkJNX0lOVkFM
SUQ7Cit9CisKKy8qKgorICogcHhhM3h4X29uZW5hbmRfY29tbWFuZCAtIFNlbmQgY29tbWFuZCB0
byBPbmVOQU5EIGRldmljZQorICogQHBhcmFtIG10ZAkJTVREIGRldmljZSBzdHJ1Y3R1cmUKKyAq
IEBwYXJhbSBjbWQJCXRoZSBjb21tYW5kIHRvIGJlIHNlbnQKKyAqIEBwYXJhbSBhZGRyCQlvZmZz
ZXQgdG8gcmVhZCBmcm9tIG9yIHdyaXRlIHRvCisgKiBAcGFyYW0gbGVuCQludW1iZXIgb2YgYnl0
ZXMgdG8gcmVhZCBvciB3cml0ZQorICoKKyAqIFNlbmQgY29tbWFuZCB0byBPbmVOQU5EIGRldmlj
ZS4gVGhpcyBmdW5jdGlvbiBpcyB1c2VkIGZvciBtaWRkbGUvbGFyZ2UgcGFnZQorICogZGV2aWNl
cyAoMUtCLzJLQiBCeXRlcyBwZXIgcGFnZSkKKyAqLworc3RhdGljIGludCBweGEzeHhfb25lbmFu
ZF9jb21tYW5kKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgY21kLAorCQkJCSAgbG9mZl90IGFk
ZHIsIHNpemVfdCBsZW4pCit7CisJc3RydWN0IHB4YTN4eF9vbmVuYW5kX2luZm8gKmluZm8gPSBt
dGQtPnByaXY7CisJc3RydWN0IHB4YTN4eF9iYm0gKmJibSA9IGluZm8tPmJibTsKKworCS8qIEdl
dCByZW9sb2NhdGVkIGFkZHJlc3MgKi8KKwlhZGRyID0gYmJtLT5zZWFyY2gobXRkLCBhZGRyKTsK
KwlyZXR1cm4gb25lbmFuZF9jb21tYW5kKG10ZCwgY21kLCBhZGRyLCBsZW4pOworfQorCitzdGF0
aWMgdm9pZCBweGEzeHhfb25lbmFuZF9pbml0X2NoaXAoc3RydWN0IHB4YTN4eF9vbmVuYW5kX2lu
Zm8gKmluZm8pCit7CisJc3RydWN0IG9uZW5hbmRfY2hpcCAqdGhpcyA9ICZpbmZvLT5vbmVuYW5k
OworCXN0cnVjdCBweGEzeHhfYmJtICpiYm0gPSBOVUxMOworCisJYmJtID0gcHhhM3h4X3F1ZXJ5
X2JibSgpOworCWlmIChiYm0pIHsKKwkJLyogTWFydmVsbCBQWEEzeHggQkJNIGlzIGluaXRpYWxp
emVkIHN1Y2Nlc3NmdWxseSAqLworCQlpbmZvLT5iYm0gPSBiYm07CisJCXRoaXMtPnNjYW5fYmJ0
ID0gYmJtLT5zY2FuX2JidDsKKwkJdGhpcy0+YmxvY2tfbWFya2JhZCA9IHB4YTN4eF9vbmVuYW5k
X2Jsb2NrX21hcmtiYWQ7CisJCXRoaXMtPmNvbW1hbmQgPSBweGEzeHhfb25lbmFuZF9jb21tYW5k
OworCX0KK30KKyNlbHNlCitzdGF0aWMgdm9pZCBweGEzeHhfb25lbmFuZF9pbml0X2NoaXAoc3Ry
dWN0IHB4YTN4eF9vbmVuYW5kX2luZm8gKmluZm8pIHt9CisjZW5kaWYKKworc3RhdGljIGludCBf
X2RldmluaXQgcHhhM3h4X29uZW5hbmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKK3sKKwlzdHJ1Y3QgcHhhM3h4X29uZW5hbmRfaW5mbyAqaW5mbyA9IE5VTEw7CisJc3RydWN0
IGZsYXNoX3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CisJ
c3RydWN0IHJlc291cmNlICpyZXMgPSBwZGV2LT5yZXNvdXJjZTsKKwl1bnNpZ25lZCBsb25nIHNp
emUgPSByZXMtPmVuZCAtIHJlcy0+c3RhcnQgKyAxOworCWludCBlcnI7CisKKwlpbmZvID0ga3ph
bGxvYyhzaXplb2Yoc3RydWN0IHB4YTN4eF9vbmVuYW5kX2luZm8pLCBHRlBfS0VSTkVMKTsKKwlp
ZiAoIWluZm8pCisJCXJldHVybiAtRU5PTUVNOworCisJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24o
cmVzLT5zdGFydCwgc2l6ZSwgcGRldi0+ZGV2LmRyaXZlci0+bmFtZSkpIHsKKwkJZXJyID0gLUVC
VVNZOworCQlnb3RvIG91dF9mcmVlX2luZm87CisJfQorCisJaW5mby0+b25lbmFuZC5iYXNlID0g
aW9yZW1hcChyZXMtPnN0YXJ0LCBzaXplKTsKKwlpZiAoIWluZm8tPm9uZW5hbmQuYmFzZSkgewor
CQllcnIgPSAtRU5PTUVNOworCQlnb3RvIG91dF9yZWxlYXNlX21lbV9yZWdpb247CisJfQorCisJ
aW5mby0+b25lbmFuZC5tbWNvbnRyb2wgPSBwZGF0YS0+bW1jb250cm9sOworCWluZm8tPm9uZW5h
bmQuaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsKKworCXB4YTN4eF9vbmVuYW5kX2lu
aXRfY2hpcChpbmZvKTsKKworCWluZm8tPm10ZC5uYW1lID0gZGV2X25hbWUoJnBkZXYtPmRldik7
CisJaW5mby0+bXRkLnByaXYgPSAmaW5mby0+b25lbmFuZDsKKwlpbmZvLT5tdGQub3duZXIgPSBU
SElTX01PRFVMRTsKKworCWlmIChvbmVuYW5kX3NjYW4oJmluZm8tPm10ZCwgMSkpIHsKKwkJZXJy
ID0gLUVOWElPOworCQlnb3RvIG91dF9pb3VubWFwOworCX0KKworI2lmZGVmIENPTkZJR19NVERf
UEFSVElUSU9OUworCWVyciA9IHBhcnNlX210ZF9wYXJ0aXRpb25zKCZpbmZvLT5tdGQsIHBhcnRf
cHJvYmVzLCAmaW5mby0+cGFydHMsIDApOworCWlmIChlcnIgPiAwKQorCQlhZGRfbXRkX3BhcnRp
dGlvbnMoJmluZm8tPm10ZCwgaW5mby0+cGFydHMsIGVycik7CisJZWxzZSBpZiAoZXJyIDw9IDAg
JiYgcGRhdGEtPnBhcnRzKQorCQlhZGRfbXRkX3BhcnRpdGlvbnMoJmluZm8tPm10ZCwgcGRhdGEt
PnBhcnRzLCBwZGF0YS0+bnJfcGFydHMpOworCWVsc2UKKyNlbmRpZgorCQllcnIgPSBhZGRfbXRk
X2RldmljZSgmaW5mby0+bXRkKTsKKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGluZm8p
OworCisJcmV0dXJuIDA7CisKK291dF9pb3VubWFwOgorCWlvdW5tYXAoaW5mby0+b25lbmFuZC5i
YXNlKTsKK291dF9yZWxlYXNlX21lbV9yZWdpb246CisJcmVsZWFzZV9tZW1fcmVnaW9uKHJlcy0+
c3RhcnQsIHNpemUpOworb3V0X2ZyZWVfaW5mbzoKKwlrZnJlZShpbmZvKTsKKworCXJldHVybiBl
cnI7Cit9CisKK3N0YXRpYyBpbnQgX19kZXZleGl0IHB4YTN4eF9vbmVuYW5kX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBweGEzeHhfb25lbmFuZF9pbmZv
ICppbmZvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisJc3RydWN0IHJlc291cmNlICpy
ZXMgPSBwZGV2LT5yZXNvdXJjZTsKKwl1bnNpZ25lZCBsb25nIHNpemUgPSByZXMtPmVuZCAtIHJl
cy0+c3RhcnQgKyAxOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisKKwlp
ZiAoaW5mbykgeworCQlpZiAoaW5mby0+cGFydHMpCisJCQlkZWxfbXRkX3BhcnRpdGlvbnMoJmlu
Zm8tPm10ZCk7CisJCWVsc2UKKwkJCWRlbF9tdGRfZGV2aWNlKCZpbmZvLT5tdGQpOworCisJCW9u
ZW5hbmRfcmVsZWFzZSgmaW5mby0+bXRkKTsKKwkJcmVsZWFzZV9tZW1fcmVnaW9uKHJlcy0+c3Rh
cnQsIHNpemUpOworCQlpb3VubWFwKGluZm8tPm9uZW5hbmQuYmFzZSk7CisJCWtmcmVlKGluZm8p
OworCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBw
eGEzeHhfb25lbmFuZF9kcml2ZXIgPSB7CisJLmRyaXZlciA9IHsKKwkJLm5hbWUJCT0gRFJJVkVS
X05BTUUsCisJCS5vd25lcgkJPSBUSElTX01PRFVMRSwKKwl9LAorCS5wcm9iZQkJPSBweGEzeHhf
b25lbmFuZF9wcm9iZSwKKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKHB4YTN4eF9vbmVuYW5kX3Jl
bW92ZSksCit9OworCitNT0RVTEVfQUxJQVMoRFJJVkVSX05BTUUpOworCitzdGF0aWMgaW50IF9f
aW5pdCBweGEzeHhfb25lbmFuZF9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZl
cl9yZWdpc3RlcigmcHhhM3h4X29uZW5hbmRfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19l
eGl0IHB4YTN4eF9vbmVuYW5kX2V4aXQodm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdp
c3RlcigmcHhhM3h4X29uZW5hbmRfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQocHhhM3h4X29u
ZW5hbmRfaW5pdCk7Cittb2R1bGVfZXhpdChweGEzeHhfb25lbmFuZF9leGl0KTsKKworTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOworTU9EVUxFX0FVVEhPUigiSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4u
emh1YW5nQG1hcnZlbGwuY29tPiIpOworTU9EVUxFX0RFU0NSSVBUSU9OKCJHbHVlIGxheWVyIGZv
ciBPbmVOQU5EIGZsYXNoIG9uIE1hcnZlbGwgUFhBM3h4Iik7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9weGEzeHhfYmJtLmMgYi9kcml2ZXJzL210ZC9weGEzeHhfYmJtLmMKaW5kZXggYmNjOWEz
NS4uMDcwZTVkMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvcHhhM3h4X2JibS5jCisrKyBiL2Ry
aXZlcnMvbXRkL3B4YTN4eF9iYm0uYwpAQCAtMjcsNiArMjcsMTAgQEAgc3RhdGljIGludCB2ZXJp
ZnlfYmJtX21hZ2ljKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBzdHJ1Y3QgcHhhM3h4X2JibSAqKmJi
bSkKIAlpbnQgcmV0OwogCiAJcmV0ID0gdmVyaWZ5X25hbmRfYmJtKG10ZCwgYmJtKTsKKwlpZiAo
cmV0ID49IDApCisJCXJldHVybiByZXQ7CisKKwlyZXQgPSB2ZXJpZnlfb25lbmFuZF9iYm0obXRk
LCBiYm0pOwogCXJldHVybiByZXQ7CiB9CiAKLS0gCjEuNS42LjUKCg==
--0016e644c18e3e1679047465b6ad--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: [PATCH] pxa: support pxa3xx onenand in saar and ttc dkb<br><br>Mar=
Message-ID: <mailman.34.1253880186.2253.linux-arm-kernel@lists.infradead.org>

vell PXA3xx bad block management is supported in pxa3xx onenand<br>device d=
river. Enable it in saar and ttc dkb platform.<br><br>Signed-off-by: Haojia=
n Zhuang &lt;<a href=3D"mailto:haojian.zhuang@marvell.com">haojian.zhuang at m=
arvell.com</a>&gt;<br>
---<br>=A0arch/arm/mach-mmp/ttc_dkb.c |=A0=A0=A0 2 +-<br>=A0arch/arm/mach-p=
xa/saar.c=A0=A0=A0 |=A0=A0=A0 2 +-<br>=A02 files changed, 2 insertions(+), =
2 deletions(-)<br><br>diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/m=
ach-mmp/ttc_dkb.c<br>
index 57d0535..dbd8cfd 100644<br>--- a/arch/arm/mach-mmp/ttc_dkb.c<br>+++ b=
/arch/arm/mach-mmp/ttc_dkb.c<br>@@ -100,7 +100,7 @@ static struct resource =
ttc_dkb_resource_onenand[] =3D {<br>=A0};<br>=A0<br>=A0static struct platfo=
rm_device ttc_dkb_device_onenand =3D {<br>
-=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D &quot;onenand&quot;,<br>+=A0=A0=A0 =
.name=A0=A0=A0 =A0=A0=A0 =3D &quot;pxa3xx-onenand&quot;,<br>=A0=A0=A0=A0 .i=
d=A0=A0=A0 =A0=A0=A0 =3D -1,<br>=A0=A0=A0=A0 .dev=A0=A0=A0 =A0=A0=A0 =3D {<=
br>=A0=A0=A0=A0 =A0=A0=A0 .platform_data=A0=A0=A0 =3D &amp;ttc_dkb_onenand_=
info,<br>diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c<b=
r>
index 8b7ea09..6892867 100644<br>--- a/arch/arm/mach-pxa/saar.c<br>+++ b/ar=
ch/arm/mach-pxa/saar.c<br>@@ -556,7 +556,7 @@ static struct resource saar_r=
esource_onenand[] =3D {<br>=A0};<br>=A0<br>=A0static struct platform_device=
 saar_device_onenand =3D {<br>
-=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D &quot;onenand&quot;,<br>+=A0=A0=A0 =
.name=A0=A0=A0 =A0=A0=A0 =3D &quot;pxa3xx-onenand&quot;,<br>=A0=A0=A0=A0 .i=
d=A0=A0=A0 =A0=A0=A0 =3D -1,<br>=A0=A0=A0=A0 .dev=A0=A0=A0 =A0=A0=A0 =3D {<=
br>=A0=A0=A0=A0 =A0=A0=A0 .platform_data=A0=A0=A0 =3D &amp;saar_onenand_inf=
o,<br>-- <br>1.5.6.5<br><br>

--001517741a14b62254047465bad3--
--001517741a14b6225c047465bad5
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0005-pxa-support-pxa3xx-onenand-in-saar-and-ttc-dkb.patch"
Content-Disposition: attachment; 
	filename="0005-pxa-support-pxa3xx-onenand-in-saar-and-ttc-dkb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g01crvu20

RnJvbSBmYjgyNjM0MWJmZmEzNjRjYjA0ODAyNjc0ZGRhNDU3NjhlM2Y4NmIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjUgU2VwIDIwMDkgMTU6NDM6MTMgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBweGE6IHN1cHBvcnQgcHhhM3h4IG9uZW5hbmQgaW4gc2FhciBhbmQgdHRjIGRrYgoKTWFy
dmVsbCBQWEEzeHggYmFkIGJsb2NrIG1hbmFnZW1lbnQgaXMgc3VwcG9ydGVkIGluIHB4YTN4eCBv
bmVuYW5kCmRldmljZSBkcml2ZXIuIEVuYWJsZSBpdCBpbiBzYWFyIGFuZCB0dGMgZGtiIHBsYXRm
b3JtLgoKU2lnbmVkLW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZl
bGwuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyB8ICAgIDIgKy0KIGFyY2gv
YXJtL21hY2gtcHhhL3NhYXIuYyAgICB8ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1w
L3R0Y19ka2IuYyBiL2FyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYwppbmRleCA1N2QwNTM1Li5k
YmQ4Y2ZkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC90dGNfZGtiLmMKKysrIGIvYXJj
aC9hcm0vbWFjaC1tbXAvdHRjX2RrYi5jCkBAIC0xMDAsNyArMTAwLDcgQEAgc3RhdGljIHN0cnVj
dCByZXNvdXJjZSB0dGNfZGtiX3Jlc291cmNlX29uZW5hbmRbXSA9IHsKIH07CiAKIHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIHR0Y19ka2JfZGV2aWNlX29uZW5hbmQgPSB7Ci0JLm5hbWUJ
CT0gIm9uZW5hbmQiLAorCS5uYW1lCQk9ICJweGEzeHgtb25lbmFuZCIsCiAJLmlkCQk9IC0xLAog
CS5kZXYJCT0gewogCQkucGxhdGZvcm1fZGF0YQk9ICZ0dGNfZGtiX29uZW5hbmRfaW5mbywKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL3NhYXIuYyBiL2FyY2gvYXJtL21hY2gtcHhhL3Nh
YXIuYwppbmRleCA4YjdlYTA5Li42ODkyODY3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4
YS9zYWFyLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvc2Fhci5jCkBAIC01NTYsNyArNTU2LDcg
QEAgc3RhdGljIHN0cnVjdCByZXNvdXJjZSBzYWFyX3Jlc291cmNlX29uZW5hbmRbXSA9IHsKIH07
CiAKIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIHNhYXJfZGV2aWNlX29uZW5hbmQgPSB7
Ci0JLm5hbWUJCT0gIm9uZW5hbmQiLAorCS5uYW1lCQk9ICJweGEzeHgtb25lbmFuZCIsCiAJLmlk
CQk9IC0xLAogCS5kZXYJCT0gewogCQkucGxhdGZvcm1fZGF0YQk9ICZzYWFyX29uZW5hbmRfaW5m
bywKLS0gCjEuNS42LjUKCg==
--001517741a14b6225c047465bad5--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.41.1254077218.2253.linux-arm-kernel@lists.infradead.org>

#ifdef CONFIG_HOTPLUG_CPU

...
void __cpuexit cpu_die(void)
{
        unsigned int cpu = smp_processor_id();

        local_irq_disable();
        idle_task_exit();

        /*
         * actual CPU shutdown procedure is at least platform (if not
         * CPU) specific
         */
        platform_cpu_die(cpu);

        /*
         * Do not return to the idle loop - jump back to the secondary
         * cpu initialisation.  There's some initialisation which needs
         * to be repeated to undo the effects of taking the CPU offline.
         */
        __asm__("mov    sp, %0\n"
        "       b       secondary_start_kernel"
                :
                : "r" (task_stack_page(current) + THREAD_SIZE - 8));
}
#endif /* CONFIG_HOTPLUG_CPU */


Please look at the above and realise that cpu_die() is only ever defined
in case that HOTPLUG_CPU is defined. So there is nothing to discard if
HOTPLUG_CPU equals to n.

And just to repeat myself....
The only correct use of __cpu* annotation is for function/data that is
used with or without HOTPLUG_CPU equals to y.
Which is NOT the case for cpu_die().

The __cpu* annotation is not a replacement for ifdeffed out code that is
not relevant for the non-HOTPLUG_CPU case.

	Sam
