From: geoff@infradead.org (Geoff Levand)
Date: Sun, 08 Feb 2015 19:54:49 -0800
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <CAHt6W4f-maGM75toP1TJV8wCZpZC3+ER9KqAnASJPhK8f_+aqg@mail.gmail.com>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
 <20150205094317.43f8554a@arm.com> <54D34592.9010903@linaro.org>
 <CAHt6W4dS-fv0U+=ch1-=X36EpyE5FA89aY8LVqbFP0+R3GvLqw@mail.gmail.com>
 <54D37108.9020103@arm.com>
 <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
 <CAHt6W4eQ3iC+sqWAn5LkkfC-XBgGWR0i6TXjWvzEsUqFh75fwQ@mail.gmail.com>
 <54D43F52.7030606@linaro.org>
 <CAHt6W4eQ1q+JxmB2o4MigDF+Li98iYhBfg2KXTTq3wGcNSCKMw@mail.gmail.com>
 <54D49DD5.3010202@linaro.org>
 <CAHt6W4f-maGM75toP1TJV8wCZpZC3+ER9KqAnASJPhK8f_+aqg@mail.gmail.com>
Message-ID: <1423454089.4605.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frediano,

On Fri, 2015-02-06 at 12:14 +0000, Frediano Ziglio wrote:
> 2015-02-06 10:56 GMT+00:00 AKASHI Takahiro <takahiro.akashi@linaro.org>:
> >> Frediano Ziglio wrote:
> >> The kernel code is supposed (at least in ARMv7) to run in SVC mode,
> >> not on HYP mode. One reason is that code that change SCTLR executed at
> >> HYP instead of SVC would not change current mode system control
> >> register. The function does not revert to HYP for this reason.
> >
> > I need understand what you mentioned here, but for arm64, Geoff's kexec lets
> > the boot cpu in hyp mode at soft_restart().
> 
> Where's Geoff code? Note however that is not maintainable in this way
> as people have to consider that future code could execute in either
> HYP or SVC mode. Did you test that all code called from soft_restart
> could do it?

Basically, when a CPU is reset it needs to be put into the exception
level it had when it first entered the kernel.

I have my arm64 kernel patches here:

  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git

The patches related to CPU reset are:

  arm64: Convert hcalls to use ISS field
  arm64: Add new hcall HVC_CALL_FUNC
  arm64: Add EL2 switch to soft_restart

-Geoff
