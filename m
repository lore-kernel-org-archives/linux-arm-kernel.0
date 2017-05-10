From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 09:28:48 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170509160322.GA15902@infradead.org>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com> <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org> <20170509160322.GA15902@infradead.org>
Message-ID: <CAK8P3a1N6kVEBtSrA+A2QccT0t8P5nHJfui_dYxWd9Tz2Qb63w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 6:03 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 09, 2017 at 06:02:50AM -0700, Christoph Hellwig wrote:
>> On Tue, May 09, 2017 at 06:00:01AM -0700, Andy Lutomirski wrote:
>> > fs/splice.c has some, ahem, interesting uses that have been the source
>> > of nasty exploits in the past.  Converting them to use iov_iter
>> > properly would be really, really nice.  Christoph, I don't suppose
>> > you'd like to do that?
>>
>> I can take care of all the fs code including this one.
>
> I spent the afternoon hacking up where I'd like this to head.  It's
> completely untested as of now:
>
>         http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/setfs-elimination

My older time64_t syscall series has the side-effect of doing something
like this to the time-related compat handlers in kernel/compat.c. If nobody
else has started looking at removing set_fs from those, I can extract
the relevant parts from my series.

      Arnd
