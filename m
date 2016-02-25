From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 25 Feb 2016 23:20:47 +0100
Subject: [PATCH 3/5] all: s390: move wrapper infrastructure to generic
 headers
In-Reply-To: <20160225202350.GB16123@yury-N73SV>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-4-git-send-email-ynorov@caviumnetworks.com>
 <20160225085140.GC3980@osiris> <20160225202350.GB16123@yury-N73SV>
Message-ID: <20160225222047.GB5950@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 11:23:50PM +0300, Yury Norov wrote:
> On Thu, Feb 25, 2016 at 09:51:40AM +0100, Heiko Carstens wrote:
> > On Wed, Feb 24, 2016 at 09:34:12PM +0300, Yury Norov wrote:
> > > diff --git a/include/linux/syscalls_structs.h b/include/linux/syscalls_structs.h
> > > new file mode 100644
> > > index 0000000..a920cbc
> > > --- /dev/null
> > > +++ b/include/linux/syscalls_structs.h
> > > @@ -0,0 +1,60 @@
> > > +#ifndef _LINUX_SYSCALL_STRUCTS_H
> > > +#define _LINUX_SYSCALL_STRUCTS_H
> > > +
> > > +struct epoll_event;
> > > +struct iattr;
> > > +struct inode;
> > > +struct iocb;
> > > +struct io_event;
> > > +struct iovec;
> > > +struct itimerspec;
> > > +struct itimerval;
> > 
> > This is not needed for s390, right? So might be worth a separate patch
> > which moves the forward declarations?
> 
> This patch also introduces __SC_WRAP, not needed as well. The idea of
> this patch is to introduce all the tricky machinery at once. If you
> think we need split it, I'm OK, but maybe it's enough to add more
> detailed description... What do you think?

Ok, I see. Then the only change I'd like to request is to update the
comment in front of the COMPAT_SYSCALL_WRAPx macro which talks about 33/31
bit pointer sizes. This doesn't make too much sense for common code :)
