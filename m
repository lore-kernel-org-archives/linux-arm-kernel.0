From: juergen127@kreuzholzen.de (Juergen Borleis)
Date: Tue, 4 Nov 2014 21:04:45 +0100
Subject: Samsung S3C6410 SoC/devicetree: how to describe RTC interrupts
 connected to two different interrupt parents?
Message-ID: <201411042104.45632.juergen127@kreuzholzen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the Samsung S3C6410 SoC comes with an RTC with two interrupts connected to two 
different interrupt controllers.

The old platform code uses this resource to describe it:

static struct resource s3c_rtc_resource[] = {
	[0] = DEFINE_RES_MEM(S3C24XX_PA_RTC, SZ_256),
	[1] = DEFINE_RES_IRQ(IRQ_RTC),  <-- channel 2 at VIC0
	[2] = DEFINE_RES_IRQ(IRQ_TICK), <-- channel 28@VIC1
};

In the devicetree I can define multiple interrupt channels with the 
keyword 'interrupts' but it seems all of them must share the same interrupt 
parent defined via 'interrupt-parent'. How to handle the special S3C6410 
case?
The file "Documentation/devicetree/bindings/rtc/s3c-rtc.txt" isn't really 
helpful.

jbo
