From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 May 2017 23:54:48 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170510033911.GE390@ZenIV.linux.org.uk>
References: <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <20170510021118.GA390@ZenIV.linux.org.uk>
 <20170510024524.GB390@ZenIV.linux.org.uk>
 <20170510031254.GC390@ZenIV.linux.org.uk>
 <20170510032137.GD390@ZenIV.linux.org.uk>
 <20170510033911.GE390@ZenIV.linux.org.uk>
Message-ID: <20170510065448.GD4115@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 04:39:12AM +0100, Al Viro wrote:
> fcntl stuff: I've decided not to put something similar into work.compat
> since I couldn't decide what to do with compat stuff - word-by-word copy
> from userland converting to struct flock + conversion to posix_lock +
> actual work + conversion to flock + word-by-word copy to userland...  Smells
> like we might be better off with compat_flock_to_posix_lock() et.al.
> I'm still not sure; played a bit one way and another and dediced to drop
> it for now.  Hell knows...

My version already is an improvement in lines of code alone.  Between
that and stopping to mess with the address limit I think it's a clear
winner.  But it's pretty independent of the rest, and I'll just run
it through Jeff and Bruce and ask them what they think.
