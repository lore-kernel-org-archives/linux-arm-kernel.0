From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Oct 2010 19:57:51 +0100
Subject: [PATCH] ARM: SAMSUNG: Bug fix spin_lock recursion in
	clk_enable() and clk_disable()
In-Reply-To: <4CBCD3A5.5070701@fluff.org>
References: <1286843980-23684-1-git-send-email-jc.lee@samsung.com>
	<4CBCD3A5.5070701@fluff.org>
Message-ID: <20101019185751.GB10325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 12:09:25AM +0100, Ben Dooks wrote:
> I'm not sure, but I don't belive that the clk_ api has
> ever been callable from non-sleepable contexts such as
> interrupt handlers.
> 
> I would welcome RMK's response (or any other response)
> about this issue?

We have traditionally allowed it from non-sleepable contexts, mainly
because the platforms I've been using it with have had such simple
clock implementations that it's not worth artifically restricting it,
or the implementation only requires a few us delay after enabling a
clock.
