From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 11:03:51 +0100
Subject: [PATCH v5 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <5665CF5A.1090207@android.com>
References: <1449000658-11475-1-git-send-email-dcashman@android.com>
 <1720878.JdEcLd8bhL@wuerfel> <5665CF5A.1090207@android.com>
Message-ID: <7610963.Sys3aageLY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 10:26:34 Daniel Cashman wrote:
> > Ideally we'd remove the #ifdef around the mmap_rnd_compat_bits declaration
> > and change this code to use
> > 
> >       if (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))
> > 
> That would result in "undefined reference to mmap_rnd_compat_bits" in
> the not-defined case, no?

No. The compiler eliminates all code paths that it knows are unused.
The IS_ENABLED() macro is designed to let the compiler figure this out.

	Arnd
