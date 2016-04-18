From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 18 Apr 2016 10:25:48 +0530
Subject: [PATCH 2/2] ARM: davinci: da850: use clk->set_parent for async3
In-Reply-To: <5712930F.7000902@lechnology.com>
References: <1460661217-7389-1-git-send-email-david@lechnology.com>
 <1460661217-7389-3-git-send-email-david@lechnology.com>
 <5712930F.7000902@lechnology.com>
Message-ID: <571468D4.3090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 April 2016 01:01 AM, David Lechner wrote:

>> +static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
>> +
>> +    /* Set the USB 1.1 PHY clock mux based on the parent clock. */
> 
> I seem to have regressed here since the last revision, this is supposed
> to read:
> 
>     /* Set the async3 clock domain mux based on the parent clock. */
> 
> Although now that I am looking at it again, it doesn't really add
> anything useful and could be omitted altogether.

Agree the comment is redundant. No need resend just for this though. I
can drop it when applying.

Thanks,
Sekhar
