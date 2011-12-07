From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 7 Dec 2011 10:42:25 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <4EDEF81A.7080100@windriver.com>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
 <20111206150855.GA5385@mudshark.cambridge.arm.com>
 <20111206152033.GB13769@linaro.org>
 <4EDEF81A.7080100@windriver.com>
Message-ID: <20111207104212.GA2910@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 01:22:34PM +0800, Bi Junxiao wrote:
> on 12/06/2011 11:20 PM Dave Martin wrote:
> >On Tue, Dec 06, 2011 at 03:08:55PM +0000, Will Deacon wrote:
> >>Hi Dave,
> >>
> >>On Fri, Nov 25, 2011 at 11:28:13AM +0000, Dave Martin wrote:
> >>>This patch adds some endianness-agnostic helpers to convert machine
> >>>instructions between canonical integer form and in-memory
> >>>representation, and also provides a transparent way to read a
> >>>single Thumb instruction from memory, without the need to know the
> >>>size in advance or write explicit condition checks.
> >>>
> >>>A canonical integer form for representing instructions is also
> >>>formalised here.
> >>>
> >>>Signed-off-by: Dave Martin<dave.martin@linaro.org>
> >>>---
> >>>  arch/arm/include/asm/opcodes.h |  162 ++++++++++++++++++++++++++++++++++++++++
> >>>  1 files changed, 162 insertions(+), 0 deletions(-)
> >>>  create mode 100644 arch/arm/include/asm/opcodes.h
> >>It looks like I might need to implement a basic disassembler for the
> >>hw_breakpoint code and I would certainly like to reuse as much code as I
> >>can. This header could obviously provide the code to fetch and format the
> >>instruction, but it would be nice to have some extra helpers to aid
> >>decoding.
> >>
> >>Tixy - how much work do you reckon it would be to rework your kprobes
> >>decoding code into a generic `here are my callbacks, please decode this
> >>instruction stream for me' type thing?
> >>
> >>All I want for hw_breakpoint is to know whether an instruction is a load or
> >>a store, but even for that it looks like I'll need to duplicate a lot of
> >>stuff.
> >Note, I'm currently waiting on Leif to repost his opcodes.h before I
> >repost my instration-swabbing additions on top of it, since the swabbing
> >stuff seems to be strictly non-urgent.
> I am also waiting for your patch to do my be8 fix.

OK -- in that case I will clean up and repost my patch anyway.

The two proposed bits of functionality in that header are independent,
so the later merge shouldn't affect what you're doing.

Cheers
---Dave
