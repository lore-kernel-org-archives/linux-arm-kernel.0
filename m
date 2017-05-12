From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 12 May 2017 00:35:21 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170512071549.GP390@ZenIV.linux.org.uk>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170512070012.7dysuhbkcas7ibaj@gmail.com>
 <20170512071549.GP390@ZenIV.linux.org.uk>
Message-ID: <20170512073521.GA7091@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 08:15:49AM +0100, Al Viro wrote:
> And converting everything to ->read_iter()/->write_iter() means an insane
> amount of code churn, not to mention coping with random bogosities in
> semantics.  ->read() and ->write() are going to stay around, pretty
> much indefinitely.

But I don't think kernel users of them have to.  I've been digging
through the calllers and will send an analysis to the list in a bit.
