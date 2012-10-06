From: tj@kernel.org (Tejun Heo)
Date: Sat, 6 Oct 2012 11:14:51 +0900
Subject: [PATCH 07/16] cgroup: fix warning when building without any subsys
In-Reply-To: <1349448930-23976-8-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-8-git-send-email-arnd@arndb.de>
Message-ID: <20121006021451.GA2601@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 04:55:21PM +0200, Arnd Bergmann wrote:
> In a configuration where the base cgroup support is enabled but
> every single cgroup subsys is turned off, CGROUP_BUILTIN_SUBSYS_COUNT
> is zero, which causes the sanity check code in cgroup_load_subsys
> to trigger:
> 
>        BUG_ON(ss->subsys_id >= CGROUP_BUILTIN_SUBSYS_COUNT);
>        BUG_ON(subsys[ss->subsys_id] != ss);

CGROUP_BUILTIN_SUBSYS_COUNT is already gone in mainline.  I suppose
this is no longer necessary?

Thanks.

-- 
tejun
