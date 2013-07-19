From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 19 Jul 2013 16:18:31 +0530
Subject: [PATCH 1/3] misc: Add crossbar driver
In-Reply-To: <20130719071728.GX7656@atomide.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
 <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
 <51E83A4F.5080904@ti.com> <51E87C98.5030001@ti.com>
 <20130719071728.GX7656@atomide.com>
Message-ID: <51E9197F.7010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 July 2013 12:47 PM, Tony Lindgren wrote:
>> On Thursday 18 July 2013 02:56 PM, Nishanth Menon wrote:
>>
>> Since the cross-bar is not limited t0 IRQ lines and applicable for
>> DMA request lines as well, making it IRQ chip doesn't make sense. Its
>> not typical pin control functionality either but at least that framework
>> is much closer to consider as an option.
>>
>> Actually its more of setting up the IRQ and DMA pins maps once
>> at boot for a given SOC based on chosen configuration by the
>> board. So I am leaning towards pinctrl as well. Just haven't
>> thought enough about whether thats the best approach.
>>
>> CC'ing Linus W and Tony L whether we can use pinctrl framework
>> for such an IP and if yes how ;-).
> If it really muxes signals then using pinctrl seems logical.
> Especially if the registers are in the SCM block.
>
> It might be already possible to handle it already with
> pinctrl-single,bits for the muxing part.
 I also thought of using the pinctrl itself.
 But then i wanted  to have the error handling as well,
 hence did this.

Regards,
 Sricharan
