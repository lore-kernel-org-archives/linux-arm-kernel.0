From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Aug 2014 15:37:00 -0700
Subject: [PATCH v2] irqchip: gic: Allow gic_arch_extn hooks to call into
 scheduler
In-Reply-To: <alpine.LFD.2.11.1408052222350.6061@knanqh.ubzr>
References: <alpine.LFD.2.11.1408041858570.6061@knanqh.ubzr>
 <1407194837-27190-1-git-send-email-sboyd@codeaurora.org>
 <53E118EE.5040205@codeaurora.org>
 <alpine.LFD.2.11.1408051537250.6061@knanqh.ubzr>
 <53E14B33.9080701@codeaurora.org>
 <alpine.LFD.2.11.1408052222350.6061@knanqh.ubzr>
Message-ID: <53EA970C.9070003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 19:34, Nicolas Pitre wrote:
>
>> It allows us to synchronize with another CPU that may be inside
>> gic_raise_softirq(). If the other CPU was in that function then this CPU
>> would wait until it was done sending the IPI to continue along and
>> reroute them. If the other CPU was just about to grab the sgi lock then
>> we would guarantee that the CPU would see the new gic_cpu_map value and
>> thus any redirection is not necessary.
> OK I get it now.
>
>> I hoped that the commit text explained this.
> I'm possibly not bright enough to get it the first time.
>
>> Honestly it probably isn't a noticeable performance boost either way 
>> but I think this is the best we can do.
> Sure, agreed.
>
>
>

Ok, so which patch is preferred?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
