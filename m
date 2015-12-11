From: dave.long@linaro.org (David Long)
Date: Fri, 11 Dec 2015 00:05:27 -0500
Subject: [RFC] kprobe'ing conditionally executed instructions
Message-ID: <566A5997.9020908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a moderate amount of code already in kprobes on ARM and the 
current ARMv8 patch to deal with conditional execution of instructions. 
One aspect of how this is handled is that instructions that fail their 
predicate and are not (technically) executed are also not treated as a 
hit kprobe. Steve Capper has suggested that the probe handling should 
still take place because we stepped through the instruction even if it 
was effectively a nop.  This would be a significant change in how it 
currently works on 32-bit ARM, and a change in the patch for ARMv8 
(although it's not likely to be much of a change in the kernel code).

I need input on this.  Do people have opinions?

-dl
