From: kernel@martin.sperl.org (Martin Sperl)
Date: Sun, 10 Jan 2016 16:45:41 +0100
Subject: [PATCH V2 0/2] serial: bcm2835: add bcm2835 auxiliar uart driver
In-Reply-To: <1057226922.507844.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <1057226922.507844.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
Message-ID: <46FD7886-510C-4F0F-A039-500D5438207B@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.01.2016, at 16:05, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi Martin,
> 
>> kernel at martin.sperl.org hat am 9. Januar 2016 um 14:07 geschrieben:
>> 
>> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> This patch series adds the bcm2835aux uart driver, which is created
>> as a wrapper arround the 8250 driver (based on recommendations by
>> Stephen Warren)
>> 
>> The device tree patch itself is not included yet because this
>> patch requires the clk-bcm2835aux driver, which is right now only
>> in clk-next, but should become available with 4.5.
> 
> it doesn't make sense without the device tree patch. IMHO it's okay as long as
> you point out the dependency and set the node status to disable.

I agree in principle, but it is the same as with the spi-bcm2835aux driver,
where I had provided a patch to the dt, that still has not been applied
yet, but with the driver itself already in the kernel.

Also the reorganisation of the dt to support the bcm2836 makes this
another moving target.

The other concern is that we would need to use defines included
from "dt-bindings/clock/bcm2835aux.h? and without those the dt will not
work.

For the record: this is what would be required:
	uart1: uart at 7e215040 {
		compatible = "brcm,bcm2835-aux-uart";
		reg = <0x7e215040 0x40>;
		interrupts = <1 29>;
                        clocks = <&aux BCM2835_AUX_CLOCK_UART>;
                        status = "disabled";
                };

I can respin the whole patchset to include this as well if you tell me to.
