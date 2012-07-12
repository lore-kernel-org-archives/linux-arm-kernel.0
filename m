From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 13 Jul 2012 00:12:27 +0800
Subject: [PATCH v3 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <20120712121636.GA2123@richard-laptop>
References: <1342093124-24658-1-git-send-email-b29396@freescale.com>
 <20120712121636.GA2123@richard-laptop>
Message-ID: <CAA+hA=T5XXQK4YhEy4w2kjTQCHu0t8fsA_+fg=koCo-v=Nk6_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 8:16 PM, Richard Zhao <linuxzsc@gmail.com> wrote:
[...]
>> +int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 val)
>> +{
>> +     u32 reg;
>> +
>> +     if (!imx_pinctrl)
>> +             return -EPROBE_DEFER;
>> +
>> +     spin_lock(&imx_pinctrl->gprlock);
> spin_lock_irqsave? We don't know whether people call it in isr.
>
Yes, we definitely should support call it in isr.
thanks for pointing out this.
Will fix it in next version.

Regards
Dong Aisheng
