From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Dec 2010 23:04:34 +0000
Subject: [PATCH 1/2] ARM: implement support for read-mostly sections
In-Reply-To: <AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk>
	<E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk>
	<AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
Message-ID: <20101205230434.GI9138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 05, 2010 at 10:18:27PM +0000, Catalin Marinas wrote:
> On 5 December 2010 11:43, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index cead889..1581f6d 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -167,6 +167,7 @@ SECTIONS
> >
> > ? ? ? ? ? ? ? ?NOSAVE_DATA
> > ? ? ? ? ? ? ? ?CACHELINE_ALIGNED_DATA(32)
> > + ? ? ? ? ? ? ? READ_MOSTLY_DATA(32)
> 
> Should we change the alignments to 64?

When we have some way to tell vmlinux.lds.S what the cache line size is.
It should be a separate patch.
