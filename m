From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 22 May 2012 09:19:25 +1000
Subject: [PATCH] ARM: at91: Add ADC driver to at91sam9260/at91sam9g20
 dtsi files
In-Reply-To: <4FBA1483.4010008@atmel.com>
References: <4FB3B1F3.6080102@atmel.com>
 <1337182626-13033-1-git-send-email-nicolas.ferre@atmel.com>
 <201205161850.54765.arnd@arndb.de>
 <20120517150601.GA28104@kroah.com>
 <20120518084446.a7b229074ea215fd7bcd1eb8@canb.auug.org.au>
 <4FBA1483.4010008@atmel.com>
Message-ID: <20120522091925.a77c21afb66e52749157b86e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Mon, 21 May 2012 12:10:11 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>
> After checking the current status of
> arch/arm/boot/dts/at91sam9g20.dtsi in linux-next, it seems the merge
> resolution has not produced a good result:
> 
> The "adc0" node, should only look like:
> 
> ahb {
>         apb {
>                 adc0: adc at fffe0000 {
>                         atmel,adc-startup-time = <40>;
>                 };
>         };
> };
> 
> without the redundant code carried by the staging git tree. In short,
> the arm-soc version is the proper one.

Rats!  That was an automatic merge resolution and I didn't even notice,
sorry.  I will fix it up today in linux-next, but someone needs to
remember to tell Linus when the second if these two trees is merged.

I will apply the following as a merge fixup patch after merging the
arm-soc tree (which comes later in my sequence):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 22 May 2012 09:17:31 +1000
Subject: [PATCH] ARM:at91: merge fixup for dtsi file

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 06ca15b..2a1d1ca 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -21,41 +21,6 @@
 			adc0: adc at fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
-
-			adc0: adc at fffe0000 {
-				compatible = "atmel,at91sam9260-adc";
-				reg = <0xfffe0000 0x100>;
-				interrupts = <5 4>;
-				atmel,adc-use-external-triggers;
-				atmel,adc-channels-used = <0xf>;
-				atmel,adc-vref = <3300>;
-				atmel,adc-num-channels = <4>;
-				atmel,adc-startup-time = <10>;
-				atmel,adc-channel-base = <0x30>;
-				atmel,adc-drdy-mask = <0x10000>;
-				atmel,adc-status-register = <0x1c>;
-				atmel,adc-trigger-register = <0x04>;
-
-				trigger at 0 {
-					trigger-name = "timer-counter-0";
-					trigger-value = <0x1>;
-				};
-				trigger at 1 {
-					trigger-name = "timer-counter-1";
-					trigger-value = <0x3>;
-				};
-
-				trigger at 2 {
-					trigger-name = "timer-counter-2";
-					trigger-value = <0x5>;
-				};
-
-				trigger at 3 {
-					trigger-name = "external";
-					trigger-value = <0x13>;
-					trigger-external;
-				};
-			};
 		};
 	};
 };
-- 
1.7.10.280.gaa39

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/23e7fd0b/attachment.sig>
