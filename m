From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 13:39:24 +0000
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <514318DE.8060601@openwrt.org>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-4-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
Message-ID: <201303151339.24421.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Florian Fainelli wrote:
> Le 03/14/13 23:12, Arnd Bergmann a ?crit :
> > With the Cortina Gemini platform gone, nothing in ARM uses
> > the Faraday 526 CPU core support any more. There is at least
> > one other platform using this (Moschip MCS814x), but the
> > efforts to get that merged into mainline appear to have
> > stalled.
> 
> I was actually wrong for MCS8140, they used a genuine ARM926EJS core, 
> newer version like MCS8142 and MCS8144 use a FA626 core that the 
> mainline kernel does not support anyway.

Ah, I see. FA626 seems quite different from FA526, and closer to an ARM926
if I'm reading the feature list correctly. There are apparently even a
bunch of newer cores from Faraday (FA726, FA606, FA646, FMP626) including
an SMP capable one.

> Someone recently announced support for a Moxart SoC which seems to use 
> the FA526 core however.

Yes, I saw that now. I'll drop the fa526 removal patch for now,
we'll see how that work progresses. The platform port is unfortunately
on an ancient kernel, and updating it will be a lot of work, so it
might not happen in the end.

	Arnd
