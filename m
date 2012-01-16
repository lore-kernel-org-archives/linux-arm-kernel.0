From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Mon, 16 Jan 2012 19:14:27 +0100
Subject: [PATCH] ARM: tls: remove covert channel via TPIDRURW
In-Reply-To: <1326728815-10236-1-git-send-email-will.deacon@arm.com>
References: <1326728815-10236-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAHXqBF+ZhY57875zsv6C3M_gHPiFLL+FbvoJqi0H2Ow1Cgx+Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/16 Will Deacon <will.deacon@arm.com>:
> TPIDRURW is a user read/write register forming part of the group of
> thread registers in more recent versions of the ARM architecture (~v6+).
>
> Currently, the kernel does not touch this register, which allows tasks
> to communicate covertly by reading and writing to the register without
> context-switching affecting its contents.
>
> This patch clears TPIDRURW when TPIDRURO is updated via the set_tls
> macro, which is called directly from __switch_to. Since the current
> behaviour makes the register useless to userspace as far as thread
> pointers are concerned, simply clearing the register (rather than saving
> and restoring it) will not cause any problems to userspace.

So why not fix it instead of leaving it useless?

Best Regards,
Micha? Miros?aw
