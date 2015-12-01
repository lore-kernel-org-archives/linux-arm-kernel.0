From: schwab@suse.de (Andreas Schwab)
Date: Tue, 01 Dec 2015 10:20:59 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151130202141.GA23254@yury-N73SV> (Yury Norov's message of
 "Mon, 30 Nov 2015 23:21:41 +0300")
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <2133692.Tueq9xZUPQ@wuerfel>
 <20151130202141.GA23254@yury-N73SV>
Message-ID: <87bnaafrt0.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> There's a tricky bug with signal stack, that Andreas also discovered.

That was only a confusion about the compat state of sys_rt_sigaction.
It just requires making sure glibc uses the correct (64bit layout)
struct kernel_sigaction.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
