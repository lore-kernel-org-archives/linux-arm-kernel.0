From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 12 May 2017 09:00:12 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
Message-ID: <20170512070012.7dysuhbkcas7ibaj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, May 9, 2017 at 1:56 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, May 09, 2017 at 08:45:22AM +0200, Ingo Molnar wrote:
> >> We only have ~115 code blocks in the kernel that set/restore KERNEL_DS, it would
> >> be a pity to add a runtime check to every system call ...
> >
> > I think we should simply strive to remove all of them that aren't
> > in core scheduler / arch code.  Basically evetyytime we do the
> >
> >         oldfs = get_fs();
> >         set_fs(KERNEL_DS);
> >         ..
> >         set_fs(oldfs);
> >
> > trick we're doing something wrong, and there should always be better
> > ways to archive it.  E.g. using iov_iter with a ITER_KVEC type
> > consistently would already remove most of them.
> 
> How about trying to remove all of them?  If we could actually get rid
> of all of them, we could drop the arch support, and we'd get faster,
> simpler, shorter uaccess code throughout the kernel.

I'm all for that!

Thanks,

	Ingo
