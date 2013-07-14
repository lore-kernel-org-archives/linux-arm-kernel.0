From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sun, 14 Jul 2013 13:33:14 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey> <loom.20130714T130546-799@post.gmane.org>
 <CAKv+Gu-fUNSZaNMgZekoCX2kOGEFDLKY1yFtKq1=yp9xQN3rOA@mail.gmail.com>
Message-ID: <loom.20130714T152342-120@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel <at> linaro.org> writes:

> 
> You will clobber the userland NEON contents of the register file if
> you don't preserve them properly. Also, kernel preemption (if enabled)
> may put your task to sleep at any time, and the context switching
> machinery is totally oblivious of NEON being used in the kernel, so
> the kernel side will get corrupted as well in this case.
> 
> I have a patch series pending (i.e., accepted but not pulled yet by
> Russell) which addresses these issues.
> 

That was what I was afraid of concerning NEON. It must be tricky to solve
without sacrificing performance, since saving/restoring the entire NEON
register file would obviously seriously impact context switch performance.
For memcpy-like applications, basically only four dword registers are
required (d0-d3) which could possibly be optimized for.
