From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 18 Jul 2013 00:52:03 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <201307180947.02456.yann.morin.1998@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <CAMuHMdXzcRxEBqavTx-kEq6CNAx5fYug0w8kjDw=vNfS2iX4Fw@mail.gmail.com>
 <20130718003408.bb9d5b51.akpm@linux-foundation.org>
 <201307180947.02456.yann.morin.1998@free.fr>
Message-ID: <20130718005203.9e9dc1d1.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Jul 2013 09:47:02 +0200 "Yann E. MORIN" <yann.morin.1998@free.fr> wrote:

> > 
> > I prefer the "option exec" approach, actually.  That way the shell-outs
> > are colocated with the code which uses
> 
> Indeed, but in this case, all the checks will be spread-out in the Kconfig
> files, and not easily locatable. Having all in a single script will also
> more easily raise eyebrows when that script appears in a diffstat. Noticing
> the 'exec' option risks being a bit less easy.

Eh, there are a million ways to screw up the kernel.

> But, that's not my call to decide. ;-)
> 
> > them and they will only be executed
> > if you've actually selected that subsystem for building (I think?).
> 
> If I understand the code correctly (which is still to be proven), the
> exec option is run at parse-time, once.

Yes, but not every Kconfig file in the tree gets parsed every time. 
For example, if arch/arm/Kconfig uses "option exec=some-slow-thing",
x86 users won't execute some-slow-thing.  This is good.
