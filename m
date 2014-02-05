From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Feb 2014 11:50:35 +0000
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <1391531796.2538.21.camel@joe-AO722>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <1391483274-20331-2-git-send-email-sujith@msujith.org>
 <1391484878.2538.11.camel@joe-AO722>
 <21232.24855.201543.400943@gargle.gargle.HOWL>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722>
Message-ID: <20140205115035.GO26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 08:36:36AM -0800, Joe Perches wrote:
> On Tue, 2014-02-04 at 08:03 +0100, Holger Schurig wrote:
> > Joe, look in linux/arch/arm/include/asm/delay.h. The macro udelay
> > cannot handle large values because of lost-of-precision.
> > 
> > IMHO udelay on ARM is broken, because it also cannot work with fast
> > ARM processors (where bogomips >= 3355, which is in sight now). It's
> > just not broken enought that someone did something against it ...   so
> > the current kludge is good enought.
> 
> Maybe something like this would be better?

No, the point of __bad_udelay() is that people doing stupidly large
udelay()s result in build errors, rather than having to run the kernel
and trip over a non-existent debugging message beacuse they haven't
built the kernel with DEBUG defined.

NAK.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
