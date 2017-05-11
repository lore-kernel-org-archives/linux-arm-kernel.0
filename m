From: bp@alien8.de (Borislav Petkov)
Date: Thu, 11 May 2017 13:22:34 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5jL6PeQmmdxh5h--fgrMK8DW_XZYpNfDOvvv_o9E3-Kxdw@mail.gmail.com>
References: <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <CAGXu5jKHVMRMKDfn+=kkbm+JkWPhoEtDwKx=QXAYxg1p9bn7PQ@mail.gmail.com>
 <CALCETrV73=cDvaSLOMvb299yaGNJYME8LC-=P+N6p7R1NN97Yg@mail.gmail.com>
 <CAGXu5jL6PeQmmdxh5h--fgrMK8DW_XZYpNfDOvvv_o9E3-Kxdw@mail.gmail.com>
Message-ID: <20170511112234.g4qmekxmq676pas6@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 04:31:00PM -0700, Kees Cook wrote:
> > I don't like silent fixups.  If we want to do this, we should BUG or
> > at least WARN, not just change the addr limit.  But I'm also not
> > convinced it's indicative of an actual bug here.
> 
> Nothing should enter that function with KERNEL_DS set, right?
> 
> BUG_ON(get_fs() != USER_DS);

We're feeling triggerhappy, aren't we? A nice juicy WARN-splat along
with a fixup looks much better than killing the box, to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
