From: james.morse@arm.com (James Morse)
Date: Thu, 09 Jun 2016 15:51:48 +0100
Subject: [PATCH v17 02/13] arm64: Add cpus_are_stuck_in_kernel
In-Reply-To: <d4f8c7961adc4b0afe733306fbc21e5bb7c8f6ee.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
 <d4f8c7961adc4b0afe733306fbc21e5bb7c8f6ee.1464974516.git.geoff@infradead.org>
Message-ID: <57598284.3090108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 03/06/16 19:13, Geoff Levand wrote:
> From: James Morse <james.morse@arm.com>
> 
> kernel/smp.c has a fancy counter that keeps track of the number of CPUs
> it marked as not-present and left in cpu_park_loop(). If there are any
> CPUs spinning in here, kexec will release them once the memory is re-used
> by the new kernel.
> 
> We can't return an error once we reach machine_kexec(), so as a sanity check
> we forbid kexec images to be loaded if there are already cpus stuck in the
> kernel, or we have multiple cpus and no way of disabling them.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [Split off from a larger patch]
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Post-split, the second paragraph of the commit message is out of place, and
doesn't describe what the patch does. Can I suggest replacing it with:

> Provide a function to expose whether this counter is non-zero, so we can use >
this when loading a new kexec image, and when calling machine_kexec().


Thanks,

James
