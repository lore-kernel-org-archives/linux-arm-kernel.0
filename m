From: eric@anholt.net (Eric Anholt)
Date: Wed, 29 Apr 2015 09:29:26 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add the necessary firmware driver
 information to the DT
In-Reply-To: <55403787.7010407@wwwdotorg.org>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-4-git-send-email-eric@anholt.net>
 <55403787.7010407@wwwdotorg.org>
Message-ID: <87y4laq4nt.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 04/27/2015 05:14 PM, Eric Anholt wrote:
>> This gets the USB power domain turned on so that DWC2 can probe, even
>> if the bootloader didn't turn it on for us (which is the case if you
>> use the RPi firmware without chainloading U-Boot).
>
>> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
>
>> +&usb {
>> +	power-domains = <&firmware POWER_DOMAIN_USB>;
>> +};
>
> That property doesn't seem to be documented in
> Documentation/devicetree/bindings/usb/dwc2.txt (which defines compatible
> = "brcm,bcm2835-usb"). Is it implemented?

power-domains is a generic property that's parsed by
drivers/base/power/domain.c.  See also
Documentation/devicetree/bindings/power/power_domain.txt&
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150429/915b498e/attachment-0001.sig>
