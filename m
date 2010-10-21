From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Oct 2010 23:39:16 +0100
Subject: [PATCH] ARM: SAMSUNG: Bug fix spin_lock recursion in	clk_enable()
	and clk_disable()
In-Reply-To: <20101019185751.GB10325@n2100.arm.linux.org.uk>
References: <1286843980-23684-1-git-send-email-jc.lee@samsung.com>	<4CBCD3A5.5070701@fluff.org>
	<20101019185751.GB10325@n2100.arm.linux.org.uk>
Message-ID: <4CC0C114.8080602@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/10 19:57, Russell King - ARM Linux wrote:
> On Tue, Oct 19, 2010 at 12:09:25AM +0100, Ben Dooks wrote:
>> I'm not sure, but I don't belive that the clk_ api has
>> ever been callable from non-sleepable contexts such as
>> interrupt handlers.
>>
>> I would welcome RMK's response (or any other response)
>> about this issue?
> 
> We have traditionally allowed it from non-sleepable contexts, mainly
> because the platforms I've been using it with have had such simple
> clock implementations that it's not worth artifically restricting it,
> or the implementation only requires a few us delay after enabling a
> clock.

Some on chip PLLs can be 150-300uS to get running.

-- 
Ben
