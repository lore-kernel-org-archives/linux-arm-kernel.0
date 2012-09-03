From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 12:39:51 +0000
Subject: [PATCH v2 17/31] arm64: System calls handling
In-Reply-To: <20120903114831.GA3313@mbp>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <20120822171309.GC2582@arm.com> <20120903114831.GA3313@mbp>
Message-ID: <201209031239.51515.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Catalin Marinas wrote:
> I forgot about this at the KS and we haven't got to a clear conclusion.
> 
> Do we (1) stick with the sys_mmap() for 64-bit systems and avoid offset
> conversion in both glibc and kernel or (2) use sys_mmap2() with a 12
> shift in glibc and (PAGE_SHIFT - 12) in the kernel wrapper?
> 
> I personally prefer (1) as it doesn't require a kernel wrapper and we
> avoid the double shifting. 

Yes, I think it's ok this way.

> A reason for (2) would be if we ever need file offsets greater than 16EB.

Let's not worry about this for now, all the other architectures will
have the same problem when we get there.

	Arnd
