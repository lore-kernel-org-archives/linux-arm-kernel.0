From: dgilbert@interlog.com (Douglas Gilbert)
Date: Wed, 03 Apr 2013 23:54:45 -0400
Subject: [PATCH] rtc: rtc-at91sam9.c add DT support
Message-ID: <515CF985.6050009@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some members of the at91 SoCs use the Real Time Timer (RTT)
and the General Purpose Backup Registers (GPBR) to implement
a real time clock (RTC). The AT91SAM9G20 is one example.

Attached is a patch to add DT support to rtc-at91sam9.c .
The patch is against lk 3.9.0-rc5 .

Below is a snippet of DT code for the 'G20 that was observed
to work with this patch:

ahb {
	apb {

		rtc {
			compatible = "atmel,at91sam9-rtc";
                          /* RTTC followed by GPBR (backup registers) */
                          reg = <0xfffffd20 0x10>, <0xfffffd50 0x10>;
                          interrupts = <1 4 7>;
                          status = "okay";
		};
	}
};

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: fg20_rtc_at91sam9.patch
Type: text/x-patch
Size: 1015 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/2c30a653/attachment.bin>
