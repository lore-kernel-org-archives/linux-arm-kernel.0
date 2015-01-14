From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 14 Jan 2015 17:25:28 +0530
Subject: [PATCH v4 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <20150112140918.GD24728@linaro.org>
References: <1420949002-3726-1-git-send-email-dave.long@linaro.org>
 <20150112140918.GD24728@linaro.org>
Message-ID: <CAHM4w1=9uU+pjL8mDLaOahhSXaG3iByz1jfFn2SiugkT-sv7PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 7:39 PM, Steve Capper <steve.capper@linaro.org> wrote:
> On Sat, Jan 10, 2015 at 11:03:15PM -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches, first
>> seen in October 2013. This version attempts to address concerns raised by
>> reviewers and also fixes problems discovered during testing, particularly during
>> SMP testing.
>>
>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>> and return probes(kretprobes) support for ARM64.
>>
>> The kprobes mechanism makes use of software breakpoint and single stepping
>> support available in the ARM v8 kernel.
>>
>> Changes since v2 include:
>>
>> 1) Removal of NOP padding in kprobe XOL slots. Slots are now exactly one
>> instruction long.
>> 2) Disabling of interrupts during execution in single-step mode.
>> 3) Fixing of numerous problems in instruction simulation code (mostly
>> thanks to Will Cohen).
>> 4) Support for the HAVE_REGS_AND_STACK_ACCESS_API feature is added, to allow
>> access to kprobes through debugfs.
>> 5) kprobes is *not* enabled in defconfig.
>> 6) Numerous complaints from checkpatch have been cleaned up, although a couple
>> remain as removing the function pointer typedefs results in ugly code.
>>
>> Changes since v3 include:
>>
>> 1) Remove table-driven instruction parsing and replace with an if statement
>> calling out to old and new instruction test functions in insn.c.
>> 2) I removed the addition of orig_x0 to ptrace.h.
>> 3) Reorder the patches.
>> 4) Replace the previous interrupt disabling (from Will Cohen) with
>> an improved solution (from Steve Capper).
>

Hi David,

If  you plan your next revision, may be  you can pick and squash
following patches from my tree
(https://github.com/pratyushanand/linux.git :
ml_arm64_uprobe_devel_v2_over_kprobe_v4)

abb0b22be54c ARM64: Move BRK opcodes defines from kprobes.h to debug-monitors.h
c82c2abaf751 ARM64: kprobe: Make prepare and handler function struct
kprobe independent
d95c226226dc ARM64: Remove definition of ARCH64_NOP_OPCODE
e5f3310a21c4 ARM64: kprobe: Fix few instruction which is to be simulated

~Pratyush
