From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:41:30 +0000
Subject: [PATCH 2/6] arm64: barriers: make use of barrier options with
 explicit barriers
In-Reply-To: <1391686253-13436-2-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-2-git-send-email-will.deacon@arm.com>
Message-ID: <20140206114130.GJ29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:30:49AM +0000, Will Deacon wrote:
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -20,14 +20,14 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#define sev()		asm volatile("sev" : : : "memory")
> +#define sev(l)		asm volatile("sev" #l : : : "memory")

Would we actually ever use sev(l) form C? And it's a new instruction
rather than an argument to the existing sev.

-- 
Catalin
