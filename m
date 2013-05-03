From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 17:29:17 +0200
Subject: [PATCH, RFC 09/22] crypto: lz4: don't build on ARM
In-Reply-To: <OF54831661.2286D403-ON49257B5F.00831E7A-49257B5F.00831E7D@lge.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <OF54831661.2286D403-ON49257B5F.00831E7A-49257B5F.00831E7D@lge.com>
Message-ID: <201305031729.17360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013, Chanho Min wrote:
> >It is not currently possible to build the LZ4 code on ARM, so let's
> >remove that option in Kconfig for now.
> >
> >lib/built-in.o: In function `lz4_compress64kctx':
> > lib/lz4/lz4_compress.c:339: undefined reference to `__ctzsi2'
> >lib/built-in.o: In function `lz4_compressctx':
> > lib/lz4/lz4_compress.c:157: undefined reference to `__ctzsi2'
> >lib/built-in.o: In function `lz4hc_commonlength':
> > lib/lz4/lz4hc_compress.c:102: undefined reference to `__ctzsi2'
> > lib/lz4/lz4hc_compress.c:102: undefined reference to `__ctzsi2'
> >lib/built-in.o: In function `lz4hc_insertandgetwidermatch':
> > lib/lz4/lz4hc_compress.c:230: undefined reference to `__ctzsi2'
> 
> Please, let me know the gcc version and tested defconfig.
> I didn't have any problem to build with gcc 4.6.4 on armv7.
> Some architecture need libgcc functions for __builtin_clz/ctz.
> Porting them to lib is in progress:
> http://marc.info/?l=linux-kernel&amp;m=136748861811956&amp;w=2
> But, It doesn't happen on ARM, PowerPC and x86.

I tested with gcc-4.8 and random configurations. I've tried it
again now and can't reproduce it at the moment. I'll try building
more random configurations until I have nailed down the problem.

Sorry about this, I should have been more careful about my
original conclusion here.

	Arnd
