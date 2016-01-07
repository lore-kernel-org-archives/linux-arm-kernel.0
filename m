From: boqun.feng@gmail.com (Boqun Feng)
Date: Thu, 7 Jan 2016 08:43:56 +0800
Subject: [PATCH v2 15/32] powerpc: define __smp_xxx
In-Reply-To: <20160106222337-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-16-git-send-email-mst@redhat.com>
 <20160105013648.GA1256@fixme-laptop.cn.ibm.com>
 <20160105085117.GA11858@redhat.com>
 <20160105095341.GA5321@fixme-laptop.cn.ibm.com>
 <20160105180938-mutt-send-email-mst@redhat.com>
 <20160106015152.GA14605@fixme-laptop.cn.ibm.com>
 <20160106222337-mutt-send-email-mst@redhat.com>
Message-ID: <20160107004356.GB14605@fixme-laptop.cn.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 10:23:51PM +0200, Michael S. Tsirkin wrote:
[...]
> > > 
> > > Sorry, I don't understand - why do you have to do anything?
> > > I changed all users of smp_lwsync so they
> > > use __smp_lwsync on SMP and barrier() on !SMP.
> > > 
> > > This is exactly the current behaviour, I also tested that
> > > generated code does not change at all.
> > > 
> > > Is there a patch in your tree that conflicts with this?
> > > 
> > 
> > Because in a patchset which implements atomic relaxed/acquire/release
> > variants on PPC I use smp_lwsync(), this makes it have another user,
> > please see this mail:
> > 
> > http://article.gmane.org/gmane.linux.ports.ppc.embedded/89877
> > 
> > in definition of PPC's __atomic_op_release().
> > 
> > 
> > But I think removing smp_lwsync() is a good idea and actually I think we
> > can go further to remove __smp_lwsync() and let __smp_load_acquire and
> > __smp_store_release call __lwsync() directly, but that is another thing.
> > 
> > Anyway, I will modify my patch.
> > 
> > Regards,
> > Boqun
> 
> 
> Thanks!
> Could you send an ack then please?
> 

Sure, if you need one from me, feel free to add my ack for this patch:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160107/b3ca90ab/attachment-0001.sig>
