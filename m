From: xjq@rock-chips.com (Jianqun)
Date: Wed, 03 Dec 2014 09:03:40 +0800
Subject: [PATCH 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
In-Reply-To: <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>	<1417531977-30094-1-git-send-email-jay.xu@rock-chips.com>
 <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
Message-ID: <547E616C.1020503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug:

? 12/03/2014 01:54 AM, Doug Anderson ??:
> Jianqun,
> 
> This ought to be a "v3" patch and ideally ought to describe
> differences from v2 (after the cut).  Please have Kever or Chris
> review your next patch before sending it out since I think they are
> familiar with the process.
> 
> 
> On Tue, Dec 2, 2014 at 6:52 AM, Jianqun Xu <jay.xu@rock-chips.com> wrote:
>> From: Sonny Rao <sonnyrao@chromium.org>
>>
>> We need to claim the clock which is driving the codec so that when we enable
>> clock gating, we continue to clock the codec when needed.  I make this an
>> optional clock since there might be some applications where we don't need it
>> but can still use the I2S block.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> 
> You still forgot your own signed-off-by.  Please try again.  See
> <https://patchwork.kernel.org/patch/5334991/>
ok, I will add my signed-off-by
> 
> 
>> +       i2s->oclk = devm_clk_get(&pdev->dev, "i2s_clk_out");
>> +       if (IS_ERR(i2s->oclk)) {
>> +               dev_dbg(&pdev->dev, "Didn't find output clock\n");
>> +               i2s->oclk = NULL;
>> +       }
> 
> You still forgot the blank line here requested by Heiko.  Please try
> again.  See <https://patchwork.kernel.org/patch/5334991/>
Although I thought there needn't a blank ~, I wll add it next patch
> 
> 
>> +       if (i2s->oclk)
>> +               ret = clk_prepare_enable(i2s->oclk);
>> +
> 
> 
> 

-- 
Jianqun Xu

****************************************************************************
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED.
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
****************************************************************************
