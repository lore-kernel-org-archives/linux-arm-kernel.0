From: eric@anholt.net (Eric Anholt)
Date: Fri, 11 Nov 2016 09:18:21 -0800
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <7a5c1318-de70-bcfc-648d-fd5a43c2fac5@wwwdotorg.org>
References: <20161027165246.23936-1-eric@anholt.net>
 <7a5c1318-de70-bcfc-648d-fd5a43c2fac5@wwwdotorg.org>
Message-ID: <87lgwqaqaq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 10/27/2016 10:52 AM, Eric Anholt wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The idea is to give useful names to GPIO lines that an implementer
>> will be using from userspace, e.g. for maker type projects.  These are
>> user-visible using tools/gpio/lsgpio.c
>
>>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 65 +++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm2835-rpi-a.dts      | 67 ++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 66 +++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 66 +++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm2835-rpi-b.dts      | 67 ++++++++++++++++++++++++++++++++
>
> Aren't the A and B rev 2 pinouts the same.

Looking at the contents of the patches and the schematics referenced
>From them: no, they aren't.

> If so, why duplicate the 
> content between the files instead of creating an inclue file? Same for 
> A+, B+, Pi 2, and Pi 3. Shouldn't this patch update the Pi 2 and Pi 3 
> DTs too?

Pi2 and 3 would be lovely.  If someone wants to write them, I'd
encourage them to.

> I think the whole point of naming GPIOs is to give users the same 
> experience across the different boards where the same semantics exist in 
> HW. Both the A+ and B+ use GPIO0/1 (a/k/a ID_SD/ID_SC a/k/a SDA0/SCL0) 
> for the same semantic purpose and are exposed in the same externally 
> visible way (same pins on the expansion header); the board ID EEPROM. 
> Therefore I assert the names of these GPIOs should be identical on all 
> boards that use them for that purpose, to allow SW (or human knowledge) 
> portability between the boards.

I weakly agree with this, but find the idea of "consistent semantics"
attached to the names rather silly given the number of ways people
reconfigure the boards (particularly given that people can pinmux
things).

That said, I agree with you on renaming ID_SD to disagree with the
schematic in favor of consistency, and I've done so.

>> +			  "GPIO17",
>
> This pin is known as GPIO_GEN0 on the expansion header. Given the 
> expansion header is all end-users likely care about, and other pins 
> (e.g. SPI_CE1_N) are named after the expansion header, shouldn't this 
> patch use the GPIO expansion header naming for all pins that are routed 
> to that header?

We've already been through this.  Users *don't* know the GENx names and
they were confusing and got eliminated in the later schematics.  This
was done for consistency, like you asked for above!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/1ba7017a/attachment.sig>
