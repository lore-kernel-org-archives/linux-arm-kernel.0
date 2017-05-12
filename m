From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 May 2017 10:20:42 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170512081154.GQ390@ZenIV.linux.org.uk>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com> <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170512070012.7dysuhbkcas7ibaj@gmail.com>
 <20170512071549.GP390@ZenIV.linux.org.uk>
 <CAK8P3a2ynRObJLn2Hh2r9_2k5+O08jErPC_UnnDmemd1jXsnkw@mail.gmail.com>
 <20170512081154.GQ390@ZenIV.linux.org.uk>
Message-ID: <CAK8P3a0rAjaw+U0smH45H6mVJ88P_Q033JDeKODQ+VmTHfKHQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 10:11 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Anyway, what's special about modules?  IDGI...

One of the arguments that came up earlier was code in external modules
being mostly unaudited, sometimes without any source code available
at all but still used in devices.

If modules can't do set_fs() any more, this could eliminate bugs with
unpaired set_fs in those modules.

Limiting factors of course are:

- embedded systems that ship come with their own kernels (as opposed
  to using whatever users have, or relying on binary distros) can just
  make it available to modules again, by reverting the patch

- As Christoph said, they could have an open-coded set_fs in the
  driver

- Whatever other method a clueless driver write might come up with
  isn't necessarily better than set_fs().

     Arnd
