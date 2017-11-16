From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 16 Nov 2017 14:29:24 -0800
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
In-Reply-To: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
References: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
Message-ID: <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> ARM: SoC driver updates for v4.15

No. This is completely broken, and I can't imagine that it has ever
compiled for *anybody*.

  drivers/soc/renesas/r8a77970-sysc.c:14:10: fatal error:
dt-bindings/power/r8a77970-sysc.h: No such file or directory
   #include <dt-bindings/power/r8a77970-sysc.h>

and the compiler is completely right. This branch added that
r8a77970-sysc.c file, but never added the header file.

And it's not some odd merge mistake of mine: I checked. That error is
there in the original branch too.

Tssk.

            Linus
