From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 May 2017 23:46:55 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5jKHVMRMKDfn+=kkbm+JkWPhoEtDwKx=QXAYxg1p9bn7PQ@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <CAGXu5jKHVMRMKDfn+=kkbm+JkWPhoEtDwKx=QXAYxg1p9bn7PQ@mail.gmail.com>
Message-ID: <20170510064655.GA4115@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 09:50:32AM -0700, Kees Cook wrote:
> http://git.infradead.org/users/hch/vfs.git/commitdiff/018e0e9030777121fe87e89d43066691e7366587
> This accidentally(?) removes the kernel-doc comments.

That was sort of intentional, the kerneldoc boilerplate adds very little
value for method instances.

> http://git.infradead.org/users/hch/vfs.git/commitdiff/78b62c730254fc39fa888cdbdca08fde6e09a798
> Could this be made defensive? (Return 0 if ret wraps, for example?) I
> see what the comment says, but not everyone will read that. :(

It's a straight copy of iov_length, and I'd rather keep it that way.
