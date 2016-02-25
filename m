From: schwab@suse.de (Andreas Schwab)
Date: Thu, 25 Feb 2016 11:50:31 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160218223506.GA7816@yury-N73SV> (Yury Norov's message of "Fri,
 19 Feb 2016 01:35:06 +0300")
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
Message-ID: <mvm8u29ukqw.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> I have new glibc that follows new ABI:
> https://github.com/norov/glibc/tree/new-api

sysdeps/unix/sysv/linux/aarch64/ilp32/getdents64.c is wrong, struct
dirent64 is not the same as struct dirent.  The file needs to be renamed
to sysdeps/unix/sysv/linux/aarch64/ilp32/getdents.c so that __getdents64
comes from sysdeps/unix/sysv/linux/generic/getdents64.c.

sysdeps/unix/sysv/linux/aarch64/ilp32/*xstat*.c should not set errno,
INLINE_SYSCALL already does that, and returns -1 on error.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
