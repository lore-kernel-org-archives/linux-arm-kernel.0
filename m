From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 30 Apr 2013 00:49:03 +0800
Subject: [v8,01/12] gpio: add gpio offset in gpio range cells property
In-Reply-To: <517E990D.10101@imgtec.com>
References: <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
 <517E990D.10101@imgtec.com>
Message-ID: <CAD6h2NTxmZqaYt6wQU3QrmUbPk9wjSSCy0JxhFp0_4MSdvEdDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 April 2013 00:00, James Hogan <james.hogan@imgtec.com> wrote:
> On 02/02/13 17:25, Haojian Zhuang wrote:
>> Add gpio offset into "gpio-range-cells" property. It's used to support
>> sparse pinctrl range in gpio chip.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> This is an ABI breakage. I've been using the #gpio-range-cells = <2>
> since around October. Please can we try and maintain backward
> compatibility in future, even if it's only temporary.
>
> Thanks
> James
>

I've updated all code with #gpio-range-cells = <3> in kernel. If you change this
back to <2>, you'll break current pinctrl-single driver. I appended this because
there may be not 1-to-1 mapping between gpio pins & pinmux pins in some
SoC. So the new parameter is used to specify the gpio pin offset.

So it's not temporary.

Regards
Haojian
