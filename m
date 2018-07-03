From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 3 Jul 2018 21:26:35 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <ac5ab301-7df6-90fb-748b-3dc4624ea3c4@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180702160158.GD65296@linux.vnet.ibm.com>
 <ac5ab301-7df6-90fb-748b-3dc4624ea3c4@linux.ibm.com>
Message-ID: <20180703192634.GA32223@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03, Ravi Bangoria wrote:
>
> Now about adding ref_ctr_offset into uprobe_consumer. Actually, I
> didn't want to change the uprobe_consumer definition because it's
> already exported and tools like systemtap are using it.

So what? Yes, the out-of-tree modules should be updated, but this doesn't
mean we can add the new features.

And, speaking of systemtap, it already has to do build-time checks to verify
that uprobe_consumer->ret_handler member exists. So it will need another
STAPCONF_INODE_REFCNT and that is all.

Oleg.
