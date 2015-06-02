From: stefan@agner.ch (Stefan Agner)
Date: Tue, 02 Jun 2015 21:42:41 +0200
Subject: [PATCH v2] ARM: nommu: avoid deprecated source register on mov
In-Reply-To: <1432337148-9894-1-git-send-email-stefan@agner.ch>
References: <1432337148-9894-1-git-send-email-stefan@agner.ch>
Message-ID: <597f1a12eb3962fcb569982659ee3196@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-23 01:25, Stefan Agner wrote:
> In Thumb2 mode, the stack register r13 is deprecated if the
> destination register is the program counter (r15). Similar to
> head.S, head-nommu.S uses r13 to store the return address used
> after configuring the CPU's CP15 register. However, since we do
> not enable a MMU, there will be no address switch and it is
> possible to use branch with link instruction to call
> __after_proc_init.
> 
> Avoid using r13 completely by using bl to call __after_proc_init
> and get rid of __secondary_switched.
> 
> Beside removing unnecessary complexity, this also fixes a
> compiler warning when compiling a !MMU kernel:
> Warning: Use of r13 as a source register is deprecated when r15
> is the destination register.

Submitted this patch to the patch tracking system, ID 8383/1.

--
Stefan
