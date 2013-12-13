From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Dec 2013 09:56:55 +0000
Subject: [PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option
In-Reply-To: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
References: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131213095655.GB4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:09:09AM +0100, Jonas Jensen wrote:
> CPU_FA526 lacks thumb state support and doesn't get along with some
> of the options enabled by ARCH_MULTI_V4T.
> 
> More specifically it doesn't get along with CPU_ARM920T:
> 
> CPU_ABRT_EV4T
> CPU_CACHE_V4WT
> CPU_COPY_V4WB
> CPU_TLB_V4WBI

Having these selected doesn't change how the kernel is compiled or how
the kernel uses the code which these provide.  These mainly control
which files are built.

They also control indirectly how the code is called - but the ultimate
decision is made by the CPU which is detected and the block in
__fa526_proc_info.

So, having these symbols enabled (provided the right ones for FA526 are
also enabled) makes no difference.  So I don't buy your explanation.
