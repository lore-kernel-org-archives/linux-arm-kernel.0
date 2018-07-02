From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 2 Jul 2018 20:05:29 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180702160158.GD65296@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180702160158.GD65296@linux.vnet.ibm.com>
Message-ID: <20180702180529.GB31400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02, Srikar Dronamraju wrote:
>
> > Implement the reference counter logic in core uprobe. User will be
> > able to use it from trace_uprobe as well as from kernel module. New
> > trace_uprobe definition with reference counter will now be:
> >
> >     <path>:<offset>[(ref_ctr_offset)]
> >
> > where ref_ctr_offset is an optional field. For kernel module, new
> > variant of uprobe_register() has been introduced:
> >
> >     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> >
>
> Sorry for bringing this again, but I would actually think the ref_ctr is
> a consumer property. i.e the ref_ctr_offset should be part of
> uprobe_consumer.

Damn yes ;) I was thinking about this too but decided to discuss this later.

But this probably means more complications, I am not sure about the actual
implementation.

Oleg.
