From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 16 Aug 2016 11:02:50 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <CAGb2v66_WAO-hm5jyeE9=J=hi8=03LH26Qev+xv1CsphH53=eQ@mail.gmail.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
 <CAGb2v66_WAO-hm5jyeE9=J=hi8=03LH26Qev+xv1CsphH53=eQ@mail.gmail.com>
Message-ID: <1b1dac2e-d653-f515-6553-e1d30b5de6f7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-08-16 04:47, Chen-Yu Tsai wrote:
> On Tue, Aug 9, 2016 at 3:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
>> ---
>>  arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>> index f27ebbb..da55b5a 100644
>> --- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>> +++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>> @@ -53,6 +53,14 @@
>>         status = "okay";
>>  };
>>
>> +&gsl1680 {
>> +       compatible = "silead,gsl3675";
>
> The silead binding should be updated with all the other
> supported chips though. It currently only lists gsl1680.

Good point. I've just send out a patch adding them.

Regards,

Hans



>
>> +       touchscreen-fw-name = "silead/gsl3675-gt90h.fw";
>> +       touchscreen-size-x = <1792>;
>> +       touchscreen-size-y = <1024>;
>> +       status = "okay";
>> +};
>> +
>>  &lradc {
>>         button at 600 {
>>                 label = "Back";
>> --
>> 2.7.4
>>
