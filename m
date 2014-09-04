From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 12:01:52 +0200
Subject: [PATCH 24/24] Add documentation about ARM64 ILP32 ABI
In-Reply-To: <1409779158-30963-25-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-25-git-send-email-apinski@cavium.com>
Message-ID: <4031586.MjMM3BtNgn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 14:19:18 Andrew Pinski wrote:
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic linux syscall interface.
> +ILP32 sets __kernel_long_t and __kernel_ulong_t both to 64bit
> +(long long).  This effects the following types:
> +* time_t: unsigned long long
> +* clock_t: unsigned long long
> +* fsword_t: long long
> +* suseconds_t: long long
> +* swblk_t: long long
> +* fd_mask_t: long long

What about data structures derived from these? I'm worried that
some of them (in particular time_t) leak into ioctl interfaces
when they are getting included in some other data structure that
is used as an ioctl argument.

Do you have a list of which data structures change based on the
scalar type changes?

	Arnd
