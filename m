From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Feb 2013 18:41:14 +0000
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
Message-ID: <20130211184114.GP9801@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 02, 2013 at 08:33:08AM +0000, Ivan Djelic wrote:
> Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
> assumptions about the implementation of memset and similar functions.
> The current ARM optimized memset code does not return the value of
> its first argument, as is usually expected from standard implementations.

How does GCC do this? By strcmping the function name and assuming that
memset is a libc implementation?

If so, maybe passing something like -ffreestanding would make sense to turn
this behaviour off in the compiler (otherwise we should also vet the rest of
the standard string functions).

Will
