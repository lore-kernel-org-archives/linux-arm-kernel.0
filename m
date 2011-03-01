From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Feb 2011 20:21:00 -0800
Subject: [PATCH 4/4] msm: scm: Get cacheline size from CTR
In-Reply-To: <alpine.LFD.2.00.1102242056010.2701@localhost6.localdomain6>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-5-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1102241959290.2701@localhost6.localdomain6>
	<4D66B505.6010702@codeaurora.org>
	<alpine.LFD.2.00.1102242056010.2701@localhost6.localdomain6>
Message-ID: <4D6C742C.40507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2011 11:56 AM, Thomas Gleixner wrote:
> On Thu, 24 Feb 2011, Stephen Boyd wrote:
>
>>
>> I definitely don't want to do it for every loop. I'm fine with getting
>> it every scm_call() invocation though.
>>
>> For now, I'll pull the end and cacheline_size variables out of the
>> do-while loop.
>
> Why not do it correct right away and retrieve it in an __init
> function?

That would require an early_initcall, so hopefully that is fine.

I wonder why the generic arm v7 cache operations don't do the same thing
and store the dcache line size somewhere. Every dma operation is
essentially calling dcache_line_size(). Perhaps some generic arm code
should be determining the dcache line size really early on and storing
it in the proc_info_list? Then both the dma code and scm code could
query the processor for the dcache line size with something like
cpu_dcache_line_size?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
