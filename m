From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 27 Jul 2018 15:59:30 +0200
Subject: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <e722ee62-eaba-3abd-7f34-bf38ba3d4f95@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
 <20180723162629.GA8584@redhat.com>
 <e722ee62-eaba-3abd-7f34-bf38ba3d4f95@linux.ibm.com>
Message-ID: <20180727135929.GB3618@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24, Ravi Bangoria wrote:
>
> > Perhaps we can even add another flag later, MMF_HAS_DELAYED_UPROBES set by
> > delayed_uprobe_add().
>
> Yes, good idea.

But let me repeat, lets do this later. We can do even better I think, say,
move this delaed-list into uprobes_state. But imo the 1st version can just
check MMF_HAS_UPROBES because this is simple, obviously correct, and can
actually help.

Oleg.
