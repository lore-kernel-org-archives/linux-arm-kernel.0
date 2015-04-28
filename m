From: g.portay@overkiz.com (g.portay at overkiz.com)
Date: Tue, 28 Apr 2015 23:12:29 +0200
Subject: [PATCH v2 0/7] ARM: at91/dt: kizbox: update and rename to
 at91-kizbox
In-Reply-To: <20150428213443.4fe481bc@bbrezillon>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
 <20150428213443.4fe481bc@bbrezillon>
Message-ID: <4b032d32c9a081ab2ba4e204238a12fa@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-28 21:34, Boris Brezillon wrote:
> On Tue, 21 Apr 2015 14:05:11 +0200
> Ga?l PORTAY <g.portay@overkiz.com> wrote:
> 
>> *** BLURB HERE ***
> We usually replace this line by a description ;-).
> 

'cause I got nothing to tell... and I like to let it be known :D

> Anyway, to the whole series:
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 

Thanks

>> 
>> Ga?l PORTAY (7):
>>   ARM: at91/dt: kizbox: rename to at91-kizbox
>>   ARM: at91/dt: at91-kizbox: sanitize file
>>   ARM: at91/dt: at91-kizbox: user proper serial uart
>>   ARM: at91/dt: at91-kizbox: gpio-keys related changes
>>   ARM: at91/dt: at91-kizbox: leds related changes
>>   ARM: at91/dt: at91-kizbox: re-size nand partitions
>>   ARM: at91/dt: at91-kizbox: update chosen node
>> 
>>  arch/arm/boot/dts/Makefile        |   2 +-
>>  arch/arm/boot/dts/at91-kizbox.dts | 159 
>> ++++++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/kizbox.dts      | 150 
>> -----------------------------------
>>  3 files changed, 160 insertions(+), 151 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
>>  delete mode 100644 arch/arm/boot/dts/kizbox.dts
>> 

By the way...

*$ cat 0001-ARM-at91-dt-kizbox-rename-to-at91-kizbox.patch~*
 From 9c0af17907451f8424b29c081780a9e9c18ae19d Mon Sep 17 00:00:00 2001
 From: =?utf-8?q?Ga=C3=ABl=20PORTAY?= <g.portay@overkiz.com>
Date: Tue, 21 Apr 2015 12:08:42 +0200
Subject: [PATCH v2 1/7] ARM: at91/dt: kizbox: rename to at91-kizbox
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset renames the kizbox board into at91-kizbox to match AT91 
naming
convention, sanitize and sorts nodes by address when possible (or
alphabeticallyi if not applicable).

It also updates the following features:
- uses proper serial uart (only USART3 is accessible),
- fixes gpio-keys active level and rename,
- moves leds to pwm support (using tcb-pwm driver) and rename as well,
- re-sizes nand mtd partitions and
- updates chosen-node (bootargs + set linux stdout path to DBGU),

Regards,
Ga?l PORTAY

Changes since v1:
- Split into patches for review

---
  arch/arm/boot/dts/Makefile                        | 2 +-
  arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} | 0
  2 files changed, 1 insertion(+), 1 deletion(-)
  rename arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d2b559d..32568fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -18,9 +18,9 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
  	tny_a9263.dtb \
  	usb_a9263.dtb \
  	at91-foxg20.dtb \
+	at91-kizbox.dtb \
  	at91sam9g20ek.dtb \
  	at91sam9g20ek_2mmc.dtb \
-	kizbox.dtb \
  	tny_a9g20.dtb \
  	usb_a9g20.dtb \
  	usb_a9g20_lpw.dtb \
diff --git a/arch/arm/boot/dts/kizbox.dts 
b/arch/arm/boot/dts/at91-kizbox.dts
similarity index 100%
rename from arch/arm/boot/dts/kizbox.dts
rename to arch/arm/boot/dts/at91-kizbox.dts
-- 
1.9.1



PS: Or blurb because I ate too many fondues before the winter comes to 
an end ;)
