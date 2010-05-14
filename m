From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Fri, 14 May 2010 12:12:53 +0300 (EEST)
Subject: [PATCH 00/15] omap: mailbox: reorganize init
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20100514.121253.116379760.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/15] omap: mailbox: reorganize init
Date: Thu, 13 May 2010 19:47:21 +0200

> Hi,
> 
> The main purpose of this patch series is to be able to compile mach platform
> data as built-in. Otherwise, client modules such as bridgedriver will load the
> platform code, but not the mach code when mailbox is built as a module.
> 
> Unfortunately, there's no easy way to do that since plat and mach code are
> deepely interrelated. So the first patches try to separate the mailbox
> registering through a defined omap_mbox_platform_data.
> 
> Also, it's worth noting that mailboxes are not a one-to-one mapping to
> resources; that is, some resources belong to multiple mboxes. So it's best to
> think of mailboxes as fake devices. That is why custom platform_data is required.
> 
> Finally, a bunch of cleaning up is done in the very first patches, specially for
> OMAP1.

Can you rebase them against the following?

  git://gitorious.org/~doyu/lk/mainline.git v2.6.34-rc7.mailbox

The above includes the unmerged patches for omap mailbox, and it seems
that yours can be applied to neither v2.6.34-rc7 or omap/master now.
