From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 25 Jul 2017 13:42:59 +0530
Subject: [PATCH 5/5] arm64: dts: msm8996: Add QFPROM node
In-Reply-To: <20170725063008.GB2016@tuxbook>
References: <20170725054705.20674-1-bjorn.andersson@linaro.org>
 <20170725054705.20674-6-bjorn.andersson@linaro.org>
 <CAFp+6iHdfA9d-unYEHSBF8d06ArLEWnmN1jpSxcLdyB9peSzsQ@mail.gmail.com>
 <20170725063008.GB2016@tuxbook>
Message-ID: <CAFp+6iGcUjQ+4Xu0POgHYRTzSK+s_ZXxr9QNm9w4HC3O08kCmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 12:00 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 24 Jul 23:09 PDT 2017, Vivek Gautam wrote:
>
>> Hi Bjorn,
>>
>>
>> On Tue, Jul 25, 2017 at 11:17 AM, Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>> > From: Vivek Gautam <vivek.gautam@codeaurora.org>
>> >
>> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> > index 395666dcce1b..d0865d2f731e 100644
>> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> > @@ -496,6 +496,17 @@
>> >                         status = "disabled";
>> >                 };
>> >
>> > +               qfprom: qfprom at 74000 {
>> > +                       compatible = "qcom,qfprom";
>> > +                       reg = <0x00074000 0x8ff>;
>> > +                       #address-cells = <1>;
>> > +                       #size-cells = <1>;
>> > +                       qusb2p_hstx_trim: hstx_trim at 24e {
>> > +                               reg = <0x24e 0x2>;
>> > +                               bits = <5 4>;
>> > +                       };
>>
>> There's one more part to it which will be used by the secondary
>> USB2 controller.
>> I was hoping to add this patch along with the USB device tree patches.
>> Let me know if you are not using this patch for anything now, i can
>> submit it along with the usb series.
>>
>
> I omitted this due to the rpmcc dependency. But I must have looked at
> the wrong node, as there is no such dependency.
>
> So this should be replaced by the full 0387312d9f35 ("arm64: dts:
> msm8996: Add device node for qcom qusb2 phy"), which has a commit
> message as well.
>
>
> Thanks for spotting my mistake.

Thanks Bjorn. I will prepare and post out these patches soon.

Best Regards
Vivek

>
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
