From: tixy@yxit.co.uk (Tixy)
Date: Thu, 11 Aug 2011 14:08:09 +0100
Subject: [PATCH 05/12] ARM: mach-s5pv210: Setup consistent dma size at
	boot time
In-Reply-To: <20110811125016.GD24434@atrey.karlin.mff.cuni.cz>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-6-git-send-email-tixy@yxit.co.uk>
	<20110811125016.GD24434@atrey.karlin.mff.cuni.cz>
Message-ID: <1313068089.6698.12.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-11 at 14:50 +0200, Pavel Machek wrote:
> 
> > -#define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
> ...
> > +	init_consistent_dma_size(14 << 20);
> 
> Are you sure that's equivalent?

Yes. From include/asm-generic/sizes.h

#define SZ_2M				0x00200000
#define SZ_4M				0x00400000
#define SZ_8M				0x00800000

The max DMA size seems to be have been defined as 14MB at some point and
several platforms define the size to be this value, but in different
ways:

	SZ_16M - SZ_2M
	SZ_8M + SZ_4M + SZ_2M
	14 << 20

I chose to use just one for consistency, and (14 << 20) seemed clearer
to me.

-- 
Jon (a.k.a. Tixy)
