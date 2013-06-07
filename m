From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 16:04:40 +0200
Subject: [PATCH v3 0/3] Separate generic header usage from
 ARCH_MULTIPLATFORM
In-Reply-To: <3354049.TGIUmJXV0H@wuerfel>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
 <51B1DC74.9090203@arm.com> <3354049.TGIUmJXV0H@wuerfel>
Message-ID: <29798869.9FjkuBXpzS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 16:00:47 Arnd Bergmann wrote:
> > Doesn't the explicit dependency of CONFIG_MMU for ARCH_MULTIPLATFORM 
> > mean that randconfig builds still work, even without the changes below?
> > 
> > Apologies if I'm missing a use-case here!
> 
> I am somewhat annoyed by the fact that I had to disable ARCH_MULTIPLATFORM
> for !MMU kernels in order to get 'make randconfig' to work and I would rather
> allow it and fix the bugs.

To expand on this a bit more: I want to eventually make ARCH_MULTIPLATFORM
mandatory for all modern platforms, in particular anything ARMv6 and ARMv7
based. Forcing all !MMU-kernels to be !ARCH_MULTIPLATFORM means we won't
get there unless we disallow !MMU on modern platforms.

	Arnd
