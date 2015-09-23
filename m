From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 23 Sep 2015 12:01:50 +0200
Subject: [PATCH 3/4] serial: bcm2835: add auxiliary uart1 to device tree
 of bcm2835
In-Reply-To: <5600C011.8020402@wwwdotorg.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
 <1441974053-2630-4-git-send-email-kernel@martin.sperl.org>
 <5600C011.8020402@wwwdotorg.org>
Message-ID: <5602788E.3070103@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.09.2015 04:42, Stephen Warren wrote:
> On 09/11/2015 05:20 AM, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Add the auxiliary uart1 device to the device tree of the bcm2835 SOC.
>
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>
>> +		uart1: uart at 7e215040 {
>> +			compatible = "ns16550";
>
> compatible should always include a precise HW-specific value; something
> like brcm,bcm2835-aux-uart. That way, if we find some other issue that
> needs working around on this HW in the future, all DTs will already
> contain the compatible value that SW needs in order to trigger that
> workaround. That's a generally true statement; i.e. irrespective of
> anything else in this series.
>
> I don't believe "ns16550" should be in the compatible value for this
> device, since the device cannot be successfully driven by SW that only
> knows about a standard 16650 UART. SW must know about the different
> divider, and there is no possibility of SW knowing about that before
> this series.
>

OK - I will look into creating a separate driver then that uses the 8250
implementation as a basis...
