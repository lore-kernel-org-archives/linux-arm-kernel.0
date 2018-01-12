From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Jan 2018 16:01:13 -0800
Subject: PM regression in next
Message-ID: <20180112000037.GA3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm seeing a considerable idle power consumption regression in
Linux next, with power consumption for my idle test system going
to 17.5mW compared to the usual 8mW on my test device.

Git bisect points to merge commit e130bc1d00a4 ("Merge branch
'akpm-current/current'") being the first bad commit.

I have also verified that commit 70286688e5ad ("ipc/mqueue.c:
have RT tasks queue in by priority in wq_add()") is good, and
commit e2d7fe89e8ae ("Merge remote-tracking branch
'init_task/init_task'") is good.

Any ideas?

Regards,

Tony
