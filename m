From: robherring2@gmail.com (Rob Herring)
Date: Wed, 11 Jan 2012 09:19:11 -0600
Subject: [PATCH 3/6] ARM: vexpress: remove incorrect BSYM usage
In-Reply-To: <20120110120402.GB2336@linaro.org>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
 <1326149146-19756-4-git-send-email-robherring2@gmail.com>
 <20120110120402.GB2336@linaro.org>
Message-ID: <4F0DA86F.3020401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2012 06:04 AM, Dave Martin wrote:
> On Mon, Jan 09, 2012 at 04:45:43PM -0600, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> BSYM macro is only needed for assembly files and its usage in c files is
>> wrong, so remove it. The linker will correctly set bit 0 for Thumb2
>> kernels.
> 
> Pawel posted a patch to do this for realview and vexpress:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/077014.html
> 
> I don't know whether this is currently headed for merge.  Without the
> ENDPROC additions in plat-versatile/platsmp.S, taking the BSYM away
> causes breakage.  (The missing ENDPROC is the true bug here.)

Pawel, what's the status? I can pick up your patch if it's not queued up.

> 
> The changes look sensible, but break realview and vexpress as-is.
> I suggest you coordinate with Pawel and either add the ENDPROC stuff
> into your series, or drop those patches (but then you'll have to wait
> to merge your series, otherwise the removal of the BSYM() macro for
> C code will cause the realview/vexpress code to break).
> 
> If you've not already done so, double-check that the target function is
> either C or properly-annotated assembler in each case.  However, so far
> as I can see, all the cases are correct, except for realview and
> vexpress.
> 
> 
> After all these changes, BSYM will only be used in:
> 
> boot/compressed/head.S
> include/asm/entry-macro-multi.S
> include/asm/unified.h
> kernel/entry-armv.S
> kernel/entry-common.S
> kernel/head-nommu.S
> kernel/head.S
> kernel/sleep.S
> lib/call_with_stack.S
> 
> ... so providing it only for assembler ought to be OK.
> 

So is that an ack for the last patch?

Rob
