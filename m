From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 23:18:57 +0100
Subject: [PATCH] arm: LLVMLinux: Calculate pt_regs address from fp
In-Reply-To: <1378503762-7236-2-git-send-email-behanw@converseincode.com>
References: <1378503762-7236-1-git-send-email-behanw@converseincode.com>
 <1378503762-7236-2-git-send-email-behanw@converseincode.com>
Message-ID: <20130906221857.GQ6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 05:42:41PM -0400, behanw at converseincode.com wrote:
> From: Behan Webster <behanw@converseincode.com>
> 
> Use the frame pointer to calculate the end of the stack for current_pt_regs()
> The existing code uses the stack pointer to do this calculation.
> Using the frame pointer yeilds the same value in a more portable way.
> This change supports being able to compile the kernel with gcc and clang.

What happens when frame pointers are disabled on gcc?
