From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 12 Aug 2011 15:09:30 +0000
Subject: [PATCH 05/12] ARM: mach-s5pv210: Setup consistent dma size at
	boot time
In-Reply-To: <1313068089.6698.12.camel@computer2>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-6-git-send-email-tixy@yxit.co.uk>
	<20110811125016.GD24434@atrey.karlin.mff.cuni.cz>
	<1313068089.6698.12.camel@computer2>
Message-ID: <20110812150929.GA5583@localhost.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2011-08-11 14:08:09, Tixy wrote:
> On Thu, 2011-08-11 at 14:50 +0200, Pavel Machek wrote:
> > 
> > > -#define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
> > ...
> > > +	init_consistent_dma_size(14 << 20);
> > 
> > Are you sure that's equivalent?
> 
> Yes. From include/asm-generic/sizes.h
> 
> #define SZ_2M				0x00200000
> #define SZ_4M				0x00400000
> #define SZ_8M				0x00800000
> 
> The max DMA size seems to be have been defined as 14MB at some point and
> several platforms define the size to be this value, but in different
> ways:
> 
> 	SZ_16M - SZ_2M
> 	SZ_8M + SZ_4M + SZ_2M
> 	14 << 20
> 
> I chose to use just one for consistency, and (14 << 20) seemed clearer
> to me.

I missed the "4" in "14". Doing 14 *1024*1024 would be more usual way
of writing this...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
