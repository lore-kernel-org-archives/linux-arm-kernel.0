From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 14:53:54 +0100
Subject: [PATCH v6 11/17] ptrace: Allow compat to use the native siginfo
In-Reply-To: <1446507046-24604-12-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-12-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5829248.7R2q3V7fJ1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 02:30:40 Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> Set COMPAT_USE_NATIVE_SIGINFO to be true for non AARCH32 tasks.
> 
> With ARM64 ILP32 ABI, we want to use the non-compat
> siginfo as we want to simplify signal handling for this new ABI.
> This patch just adds a new define COMPAT_USE_NATIVE_SIGINFO and
> if it is true then read/write in the compat case as it was the
> non-compat case.

Why does this use compat_ptrace_request()? I assume there is
a good reason for it, but I'm surprised you don't use the native
64-bit ptrace syscall.

	Arnd
