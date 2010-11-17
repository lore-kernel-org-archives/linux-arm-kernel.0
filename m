From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Nov 2010 12:18:13 +0100
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of unsigned
	long for physical addresses
In-Reply-To: <AANLkTinDGk2HPg7py9nzsqmM3_AbSG_GJJYwsiMr+wQL@mail.gmail.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<20101116193335.GD21926@n2100.arm.linux.org.uk>
	<AANLkTinDGk2HPg7py9nzsqmM3_AbSG_GJJYwsiMr+wQL@mail.gmail.com>
Message-ID: <201011171218.13910.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 November 2010, Catalin Marinas wrote:
> >
> > It may make sense to mark it const volatile, as that's the most
> > permissive set of attributes possible (iow, it'll accept any pointer
> > without warning.)  However, might be an idea to check what other
> > arches do.
> 
> The majority of architectures use volatile and a few add both const
> and volatile.
> 
> I usually use the generic headers as reference for function prototypes
> and that's just using volatile without a const (cc'ing Arnd for any
> view on this).

const volatile sounds right here, I can also change the generic header
if we agree to do the same in arm.

	Arnd
