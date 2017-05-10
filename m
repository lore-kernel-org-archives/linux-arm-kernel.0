From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 10 May 2017 03:11:18 +0100
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170509160322.GA15902@infradead.org>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
Message-ID: <20170510021118.GA390@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 09:03:22AM -0700, Christoph Hellwig wrote:
> On Tue, May 09, 2017 at 06:02:50AM -0700, Christoph Hellwig wrote:
> > On Tue, May 09, 2017 at 06:00:01AM -0700, Andy Lutomirski wrote:
> > > fs/splice.c has some, ahem, interesting uses that have been the source
> > > of nasty exploits in the past.  Converting them to use iov_iter
> > > properly would be really, really nice.  Christoph, I don't suppose
> > > you'd like to do that?
> > 
> > I can take care of all the fs code including this one.

Oh?

> I spent the afternoon hacking up where I'd like this to head.  It's
> completely untested as of now:
> 
> 	http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/setfs-elimination

And just what happens to driver that has no ->read_iter()?  Unless I'm
seriously misreading that, NAK with extreme prejudice.
