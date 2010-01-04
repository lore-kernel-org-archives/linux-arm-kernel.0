From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2010 10:30:51 +0000
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
	<771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
	<f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
	<771cded01001031827j28dc6aa9l5425669f2ceeb27a@mail.gmail.com>
	<f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
Message-ID: <20100104103051.GB9107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 10:49:05AM +0800, Eric Miao wrote:
> On Mon, Jan 4, 2010 at 10:27 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
> > get_irqnr_preamble can only carries one base parameter and one tmp
> > parameter. base parameter is already used for interrupt control
> > register. Only one tmp parameter is left for use. If we want to check
> > chip id, one parameter is not enought.
> 
> I'm a bit confused, but those are just registers that the macro is able to use,
> not something as parameters??

Correct - they're for sanity with the rest of the code.  They're a way
of saying "this macro can use these registers", and the rest of the code
which calls the macros really doesn't care what you do with them in the
macro.

Imagine what the situation would be if we didn't do this, and everyone
used their own sets of registers in these macros - it'd quickly become
impossible to safely modify the surrounding code, since we wouldn't
know what registers the macro used.
