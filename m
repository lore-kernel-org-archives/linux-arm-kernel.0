From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 8 May 2015 17:49:22 +0900
Subject: [PATCH] drm/rockchip: Add BGR formats to VOP
In-Reply-To: <554C766A.8070103@rock-chips.com>
References: <1431072968-12696-1-git-send-email-tfiga@chromium.org>
 <554C766A.8070103@rock-chips.com>
Message-ID: <CAAFQd5CK2eqXKix4rmg2bLm41EFZjK40JFWcYy=h7eyW4Wn6-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for review.

On Fri, May 8, 2015 at 5:40 PM, Mark yao <mark.yao@rock-chips.com> wrote:
>> @@ -233,6 +243,7 @@ static const struct vop_win_phy win23_data = {
>>         .nformats = ARRAY_SIZE(formats_234),
>>         .enable = VOP_REG(WIN2_CTRL0, 0x1, 0),
>>         .format = VOP_REG(WIN2_CTRL0, 0x7, 1),
>> +       .rb_swap = VOP_REG(WIN0_CTRL0, 0x1, 12),
>
> Should be:
>
>         .rb_swap = VOP_REG(VOP_WIN2_CTRL0, 0x1, 12),
>

Right, good catch.

>>         .dsp_info = VOP_REG(WIN2_DSP_INFO0, 0x0fff0fff, 0),
>>         .dsp_st = VOP_REG(WIN2_DSP_ST0, 0x1fff1fff, 0),
>>         .yrgb_mst = VOP_REG(WIN2_MST0, 0xffffffff, 0),
>> @@ -246,6 +257,7 @@ static const struct vop_win_phy cursor_data = {
>>         .nformats = ARRAY_SIZE(formats_234),
>>         .enable = VOP_REG(HWC_CTRL0, 0x1, 0),
>>         .format = VOP_REG(HWC_CTRL0, 0x7, 1),
>> +       .rb_swap = VOP_REG(WIN0_CTRL0, 0x1, 12),
>
> cursor win not support rb_swap, remove it.
>

Hmm, according to the datasheet of RK3288 I have (0.7, October 2014),
there is a field called hwc_rb_swap at bit 12 of HWC_CTRL0 register.
Is it an error in the datasheet?

Best regards,
Tomasz
