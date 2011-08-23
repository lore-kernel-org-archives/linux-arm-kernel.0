From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Aug 2011 18:15:47 +0200
Subject: [PATCH v2 1/4] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <201108231801.20595.arnd@arndb.de>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
	<201108231801.20595.arnd@arndb.de>
Message-ID: <201108231815.47151.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 August 2011, Arnd Bergmann wrote:
> > +
> > +void __iomem *sirfsoc_rtciobrg_base;
> > +static DEFINE_SPINLOCK(rtciobrg_lock);
> 
> sirfsoc_rtciobrg_base should be static as well. No other code can
> properly access it anyway since the lock is static, too.

Ah, I understand now how it's used from assembly code, but it took me a while
to figure out why it's done that way and that I couldn't come up with a better
solution either. Please add a comment above sirfsoc_rtciobrg_base and
sirfsoc_pwrc_base explaining that they are used from the suspend code and
that you don't need locking there.

	Arnd
