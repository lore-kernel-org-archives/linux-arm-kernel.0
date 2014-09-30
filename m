From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 30 Sep 2014 10:33:21 +0100
Subject: [PATCH] arm: kprobes-test: Fix compile error "bad immediate
 value for offset"
In-Reply-To: <20140926151947.GV5182@n2100.arm.linux.org.uk>
References: <1411743864.1529.36.camel@linaro1.home>
 <20140926151947.GV5182@n2100.arm.linux.org.uk>
Message-ID: <1412069601.1466.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-26 at 16:19 +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 26, 2014 at 04:04:24PM +0100, Jon Medhurst (Tixy) wrote:
> > When compiling kprobes-test-arm.c the following error has been observed
> > 
> > /tmp/ccoT403o.s:21439: Error: bad immediate value for offset (4168)
> > 
> > This is caused by the compiler spilling it's literal pool too far away
> > from the site which is trying to reference it with a PC relative load.
> > This arises because the compiler is underestimating the size of the
> > inline assembler code present, which apparently it approximates as 4
> > bytes per line or instruction.
> > 
> > We fix this problem by moving the operations which generate more than
> > 4 bytes out of the text section. Specifically, moving the .ascii
> > directives to the .rodata section.
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> > 
> > Russell, OK to add your 'reported-by' here (or should it be Olof)?
> 
> I suspect it should be Olof - I'm just the middle man, spotting errors
> in Olof's build results... though it did help that it was my for-next
> branch which was being built.

I've added this patch to the patch tracker as 8179/1

I didn't add a Reported-by as I didn't receive a response from Olof and
didn't want to add him without his say so; and I am assuming this matter
isn't worth wasting peoples time chasing up...

-- 
Tixy
