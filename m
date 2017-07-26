From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Jul 2017 13:00:02 -0700
Subject: [PATCH] ARM: dts: bcm283x: Move the BCM2837 DT contents from
 arm64 to arm.
In-Reply-To: <a2e79c17-f345-e7f2-8438-d4754e4ceb3a@broadcom.com>
References: <20170719201916.22369-1-eric@anholt.net>
 <a2e79c17-f345-e7f2-8438-d4754e4ceb3a@broadcom.com>
Message-ID: <87y3rbx931.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scott Branden <scott.branden@broadcom.com> writes:

> Hi Eric,
>
> suggestion inline
>
>
> On 17-07-19 01:19 PM, Eric Anholt wrote:
>> BCM2837 is somewhat unusual in that we build its DT on both arm32 and
>> arm64.  Most devices are being run in arm32 mode.
>>
>> Having the body of the DT for 2837 separate from 2835/6 has been a
>> source of pain, as we often need to make changes that span both
>> directories simultaneously (for example, the thermal changes for 4.13,
>> and pinmuxing changes earlier).  Other changes are made more
>> complicated than they need to be, such as the SDHOST enabling, because
>> we end up splitting a single change into a 283[56] half and a 2837
>> half.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> I had asked about what we could do about our DT merging troubles back
>> in https://lkml.org/lkml/2017/5/16/707 with no response.  I'm hoping
>> we can take this patch as a resolution to that, and submit (almost
>> all) future RPi DT changes through the arm32 dt tree.
>>
>>
>>   arch/arm/boot/dts/bcm2837-rpi-3-b.dts              | 42 +++++++++++++++++++++-
>>   .../dts/broadcom => arm/boot/dts}/bcm2837.dtsi     |  0
>>   arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   | 42 +---------------------
>>   3 files changed, 42 insertions(+), 42 deletions(-)
>>   rename arch/{arm64/boot/dts/broadcom => arm/boot/dts}/bcm2837.dtsi (100%)
>>
>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> index c72a27d908b6..972f14db28ac 100644
>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> @@ -1 +1,41 @@
>> -#include "arm64/broadcom/bcm2837-rpi-3-b.dts"
>> +/dts-v1/;
>> +#include "bcm2837.dtsi"
>> +#include "bcm2835-rpi.dtsi"
>> +#include "bcm283x-rpi-smsc9514.dtsi"
>> +#include "bcm283x-rpi-usb-host.dtsi"
> If you're moving this back to the arm directory why not change the 
> include path and remove the 4 symlinks in arm64/boot/dts/broadcom?
>
> +#include "arm/bcm2837.dtsi"
> +#include "arm/bcm2835-rpi.dtsi"
> +#include "arm/bcm283x-rpi-smsc9514.dtsi"
> +#include "arm/bcm283x-rpi-usb-host.dtsi"

Even better, it seems we don't need the arm/ here -- when we're
processing the include in arm/, the neighboring files get found.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/a13ee4ec/attachment-0001.sig>
