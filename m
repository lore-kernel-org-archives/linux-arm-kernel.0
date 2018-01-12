From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 11 Jan 2018 16:18:37 -0800
Subject: PM regression in next
In-Reply-To: <20180112000037.GA3875@atomide.com>
References: <20180112000037.GA3875@atomide.com>
Message-ID: <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Jan 2018 16:01:13 -0800 Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> I'm seeing a considerable idle power consumption regression in
> Linux next, with power consumption for my idle test system going
> to 17.5mW compared to the usual 8mW on my test device.
> 
> Git bisect points to merge commit e130bc1d00a4 ("Merge branch
> 'akpm-current/current'") being the first bad commit.
> 
> I have also verified that commit 70286688e5ad ("ipc/mqueue.c:
> have RT tasks queue in by priority in wq_add()") is good, and
> commit e2d7fe89e8ae ("Merge remote-tracking branch
> 'init_task/init_task'") is good.

Do you mean that everything up to and including 70286688e5ad
("ipc/mqueue.c: have RT tasks queue in by priority in wq_add()") is
good?
