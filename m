From: john.stultz@linaro.org (John Stultz)
Date: Tue, 9 Aug 2016 21:58:20 -0700
Subject: [RFC][PATCH 3/4] arm64: dts: hikey: Add hikey support for
 syscon-reboot-mode
In-Reply-To: <20160810043424.GH26240@tuxbot>
References: <1470697426-16426-1-git-send-email-john.stultz@linaro.org>
 <1470697426-16426-3-git-send-email-john.stultz@linaro.org>
 <20160810043424.GH26240@tuxbot>
Message-ID: <CALAqxLVQrL52Z_A5yO+UfBWcva7gUvawq=gv+WWyV51rz2iuyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 9:34 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 08 Aug 16:03 PDT 2016, John Stultz wrote:
>
> [..]
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> [..]
>>       memory at 0 {
>>               device_type = "memory";
>>               reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
>> -                   <0x00000000 0x05f00000 0x00000000 0x00eff000>,
>> +                   <0x00000000 0x05f00000 0x00000000 0x00001000>,
>> +                   <0x00000000 0x05f02000 0x00000000 0x00efd000>,
>>                     <0x00000000 0x06e00000 0x00000000 0x0060f000>,
>>                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
>>       };
>
> As I said when talked about this, I don't think you should punch holes
> in the /memory node, but rather add these regions as no-map in a
> /reserved-memory node. But that's a unrelated matter.

Yea. I need to sync w/ Wei and Guodong to see about reworking all of
those to use /reserved-memory, but for now I'd like to stay in sync w/
how they have it setup.

>>
>> +     reboot-mode-syscon at 5f01000 {
>> +             compatible = "syscon", "simple-mfd";
>> +             reg = <0x0 0x05f01000 0x0 0x00001000>;
>> +
>> +             reboot-mode at 0 {
>
> Drop the @0

Will do.


>
> Other than that:
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks!
-john
