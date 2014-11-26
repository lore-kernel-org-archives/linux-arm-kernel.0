From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 10:09:19 +0000
Subject: [PATCH v3 1/5] arm64: Kprobes with single stepping support
In-Reply-To: <54757734.4060301@linaro.org>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <1416292375-29560-2-git-send-email-dave.long@linaro.org>
 <20141118145643.GO18842@arm.com>
 <CA+b37P337jcTCPTg4Ydxh6TKwqmyMngt-eEowzfsTNBDZ7-NEg@mail.gmail.com>
 <20141119112553.GC15985@arm.com> <546CAF5A.4060901@linaro.org>
 <54757734.4060301@linaro.org>
Message-ID: <20141126100919.GA9040@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 06:46:12AM +0000, David Long wrote:
> On 11/19/14 09:55, David Long wrote:
> > On 11/19/14 06:25, Will Deacon wrote:
> >> I was thinking of the magic hex numbers in the kprobes decode tables,
> >> which
> >> seem to correspond directly to the instruction classes described in
> >> insn.c
> >>
> >> Keeping the actual emulation code separate makes sense.
> >>
> > Of course that follows the model of the much more complex arm32
> > kprobes/uprobes decoding.  I can have a go at replacing it with insn.c
> > calls.
> 
> While the existing aarch64_get_insn_class() function in insn.c is 
> somewhat useful here what is really needed is a function that identifies 
> if an instruction uses the pc (branch, load literal, load address). 
> Such instructions cannot be arbitrarily moved around in isolation, and 
> do not fall neatly into the existing "class"es.  I've written a simple 
> aarch64_insn_uses_pc() function to add to insn.c but I'd like to hear 
> agreement that this is a good approach before sending out the patch. 
> Thoughts?

I'm perfectly happy with extending insn.c with extra helpers if they're
useful to you.

Will
