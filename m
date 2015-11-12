From: schwab@suse.de (Andreas Schwab)
Date: Thu, 12 Nov 2015 09:58:43 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <10433819.KzDuoxzSn7@wuerfel> (Arnd Bergmann's message of "Thu,
 12 Nov 2015 00:23:43 +0100")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <20577001.4Nl3YnQ8k2@wuerfel> <87k2pojfsy.fsf@igel.home>
 <10433819.KzDuoxzSn7@wuerfel>
Message-ID: <mvmoaezy4os.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I think either way is fine for the two examples. I think it's clear
> that we want __NR_llseek as 62 and __NR_mmap2 as 222. Whether those
> use the compat_sys_llseek/compat_sys_mmap2_wrapper or
> sys_lseek/sys_mmap entry points is not overly important, we can use
> whatever is more convenient to glibc: if we can kill off an
> architecture specific wrapper function in glibc by adding one line
> to the kernel, that seems worthwhile.

Currently most off_t-like syscalls need a new glibc wrapper since the
existing ones are either for 32bit off_t+off64_t (with split off64_t
syscall arguments) or pure 64bit off_t architectures.  Since ilp32 now
(mostly) has 32bit off_t, but 64bit off_t-like syscalls neither of them
fit.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
