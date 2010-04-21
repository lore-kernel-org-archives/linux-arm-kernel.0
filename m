From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 22 Apr 2010 00:47:37 +0200
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <q2h3f34cd261004211535vb6ebbaa0k551449e9a1a10285@mail.gmail.com>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
	<20100415075831.GL30801@buzzloop.caiaq.de>
	<i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
	<20100416083632.GF30801@buzzloop.caiaq.de>
	<z2z3f34cd261004191240nce56a951jb24c4ce3c0c47503@mail.gmail.com>
	<20100420081323.GD30807@buzzloop.caiaq.de>
	<q2h3f34cd261004211535vb6ebbaa0k551449e9a1a10285@mail.gmail.com>
Message-ID: <20100421224737.GU30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 04:35:12PM -0600, Badguy Badguy wrote:
> Thanks for your input.
> 
> I got the NFS to mount, was missing an option in the config.
> 
> but now I get a panic - not syncing: Attempted to kill init!

That can have tons of reasons. Try setting CONFIG_DEBUG_USER=y in your
.config and pass user_debug=255 in the kernel command line. That will
give you a more verbose output about why user space programms crash.

> I verified I am passing the string via bootloader:
> init=/sbin/init
>  this is a symlink to my busybox.
> 
> I think perhaps this is a complier problem, not 100% sure tho.
> I believe I have recompiled the busybox via ltib and that should have solved it.

Earlier in this thread you said that you run the same RootFS with an
older kernel, at least I got you so. If that's true, compare their
configs again.

My rough guess is some confusion in the OABI/EABI and floating point
settings.

> can you tell me what toolchain you are using to compile this kernel?
> where you obtained it? did you compile it yourself?

I'm using buildroot (http://buildroot.busybox.net) for such things, and
the complete toolchain is built from scratch, yes. Eventually, you'll
get a complete rootfs.

Daniel
