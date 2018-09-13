From: miguel.ojeda.sandonis@gmail.com (Miguel Ojeda)
Date: Thu, 13 Sep 2018 06:02:54 +0200
Subject: [PATCH] include/linux/compiler-clang.h: define __naked
In-Reply-To: <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
References: <20180910060455.20409-1-stefan@agner.ch>
 <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
 <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
Message-ID: <CANiq72=BE8ygC6r4cJ2TshwOKCEv0C8F2xmpLRhSVMfqq16xUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Wed, Sep 12, 2018 at 6:19 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I will do a bigger one tomorrow or so and see if there are any
> important differences. Regardless of what we do, I will send the
> __naked patches separately as well (requested by Nick on GitHub).

So I did a comparison with a full allyesconfig between -rc2 and -rc2 +
v4. I find quite a lot binary differences, but not a single objdump -d
difference (object file by object file) just by fixing UTS_RELEASE to
the same value, so I guess that is a very good sign in case someone
wants to pick the entire series sooner than expected. Regardless, I
will send the separate __naked patches.

I should note that, at some point in one of my allyesconfig builds I got this:

  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
ld: drivers/edac/amd64_edac.o(.text+0x200031d2): reloc against
`__asan_load4_noabort': error 4
ld: final link failed: Nonrepresentable section on output
Makefile:1035: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Running make (without cleaning) didn't reproduce it, and the other
allyesconfig builds didn't suffer any problem either. Maybe my
hardware is failing, but I wanted to let you know nevertheless.

Cheers,
Miguel
