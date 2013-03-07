From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 7 Mar 2013 12:00:14 +0800
Subject: [RFC PATCH] ARM: keep __my_cpu_offset consistent with generic one
In-Reply-To: <20130307034454.GE25137@mudshark.cambridge.arm.com>
References: <1362624468-5451-1-git-send-email-tom.leiming@gmail.com>
 <20130307034454.GE25137@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVOcacLS82Mw1uMmC=VhYPkzqzdHnXa93QqZjAOz2gfM3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 7, 2013 at 11:44 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> For the record, can you include a backtrace or something please? The

lock_release_holdtime() will access percpu variable, so every lock
release may trigger the hang if CONFIG_LOCK_STAT is enabled,
and there are many lock acquire/release before setup_arch.

No detailed backtrace since only early_printk can work at that time.

> description makes it sounds like a caller bug, so it would be good to
> document a valid user of per-cpu before cpu_init().

OK, I will add the document: lockdep will use percpu variable
before cpu_init() called inside setup_arch().

Thanks,
-- 
Ming Lei
