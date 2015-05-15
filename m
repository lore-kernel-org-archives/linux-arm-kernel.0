From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 May 2015 12:34:48 +0100
Subject: [PATCH 1/2] ARM: cache-l2c: Detect whether it's safe to unlock
In-Reply-To: <1431416355-7693-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1431416355-7693-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150515113448.GI2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 09:39:14AM +0200, Sjoerd Simons wrote:
> The L2C cache should only be unlocked when the cache is setup to allow
> that. In the common case the l2x0 driver sets up the cache for that to
> be the case (e.g. setting L310_AUX_CTRL_NS_LOCKDOWN on L2C-310), making
> unlock safe. However when a secure firmware is in use, it may not be
> possible for the L2c to be configured that way making unlocking unsafe.
> 
> To handle that, for caches where special configuration is needed to allow
> unlocking, check whether this has been setup before unlocking.

I've come up with a different solution to this, which of course I prefer.
I'll post the patches later today, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
