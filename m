From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 15:16:56 +0100
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <20140218140429.GE17984@lunn.ch>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218140429.GE17984@lunn.ch>
Message-ID: <20140218151656.7056009b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 18 Feb 2014 15:04:29 +0100, Andrew Lunn wrote:

> > +	/*
> > +	 * A date after January 19th, 2038 does not fit on 32 bits and
> > +	 * will confuse the kernel and userspace. Reset to a sane date
> > +	 * (January 1st, 2013) if we're after 2038.
> > +	 */
> 
> Hi Thomas
> 
> Would it be better to reset back to 01/01/1970? When we do reach 32
> bit rollover, and assuming the world continues to exist, it has a
> better chance of being right than 01/01/2013.

I must say I don't really care which "sane date" we use for the RTC,
but I don't understand your argument.

Why would 01/01/1970 be more "right" than any other random date? If
the RTC has a date past 2^32, then we have absolutely no way of
converting this date into something sane that fits under 2^32, so
setting either 01/01/1970, 01/01/2013, or 12/11/2025 is just about the
same. And actually 01/01/2013 has a much higher chance of being closer
to the right date, because the boards I've seen affected by this
problem are the new Armada 375/38x boards, which have been manufactured
starting in 2013.

That being said, I don't care about which date is chosen. Just let me
know if you want me to resend the patch with a reset to 01/01/1970.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
