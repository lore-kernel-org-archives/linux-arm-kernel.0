From: eric@anholt.net (Eric Anholt)
Date: Tue, 31 Jan 2017 13:59:39 -0800
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3, for arm (32)
In-Reply-To: <87fukcgsqp.fsf@eliezer.anholt.net>
References: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
 <87fukcgsqp.fsf@eliezer.anholt.net>
Message-ID: <878tpqki0k.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> [ Unknown signature status ]
> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  arch/arm/boot/dts/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 7327250..82a760d 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -70,7 +70,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>>  	bcm2835-rpi-b-plus.dtb \
>>  	bcm2835-rpi-a-plus.dtb \
>>  	bcm2836-rpi-2-b.dtb \
>> -	bcm2835-rpi-zero.dtb
>> +	bcm2835-rpi-zero.dtb \
>> +	../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
>>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>  	bcm4708-asus-rt-ac56u.dtb \
>>  	bcm4708-asus-rt-ac68u.dtb \
>
> This would be really nice to have.
>
> Acked-by: Eric Anholt <eric@anholt.net>
>
> ARM upstream folks, do you have any issues with this?

Absent any feedback from ARM maintainers, I think we're about ready to
go with this.

Unfortunately, I just remembered yesterday that one of the requirements
is that we not use these sorts of ../../../ references in the DT tree.
Instead we have to use symlinks -- see arch/arm64/boot/dts/broadcom/ for
how we did the last round of this.

I think just having links from
arch/arm64/boot/dts/broadcom/bcm2837*.dts* to arch/arm/boot/dts/ would
be the solution, then this Makefile could just reference
bcm2837-rpi-3-b.dtb.

Would you be able to respin this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/fc61b52e/attachment.sig>
