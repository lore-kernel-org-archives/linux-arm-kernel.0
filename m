From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 12 May 2017 01:11:26 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAK8P3a2ynRObJLn2Hh2r9_2k5+O08jErPC_UnnDmemd1jXsnkw@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170512070012.7dysuhbkcas7ibaj@gmail.com>
 <20170512071549.GP390@ZenIV.linux.org.uk>
 <CAK8P3a2ynRObJLn2Hh2r9_2k5+O08jErPC_UnnDmemd1jXsnkw@mail.gmail.com>
Message-ID: <20170512081126.GA7188@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 09:43:40AM +0200, Arnd Bergmann wrote:
> How realistic and how useful would it be to first completely eliminate
> the ones that are in loadable modules and then wrapping the definition
> in #ifndef MODULE (or even make it an extern function)?

Should be fairly doable and might be a nice step towards cleaning the
mess up.  In fact with my seres a large part of those are gone, and
most of the remaining handler are ioctl handlers or what seems like
opencoded versions of probe_kernel_read.

But it won't help against exploits modifying addr_limit manually.
