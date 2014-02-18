From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Feb 2014 15:53:01 +0100
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <20140218151656.7056009b@skate>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218140429.GE17984@lunn.ch> <20140218151656.7056009b@skate>
Message-ID: <20140218145301.GF17984@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:16:56PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Tue, 18 Feb 2014 15:04:29 +0100, Andrew Lunn wrote:
> 
> > > +	/*
> > > +	 * A date after January 19th, 2038 does not fit on 32 bits and
> > > +	 * will confuse the kernel and userspace. Reset to a sane date
> > > +	 * (January 1st, 2013) if we're after 2038.
> > > +	 */
> > 
> > Hi Thomas
> > 
> > Would it be better to reset back to 01/01/1970? When we do reach 32
> > bit rollover, and assuming the world continues to exist, it has a
> > better chance of being right than 01/01/2013.
> 
> I must say I don't really care which "sane date" we use for the RTC,
> but I don't understand your argument.

I've no idea what the plans are for January 19th, 2038, but one
possible solution is to move the epoch to January 19th, 2038. And with
any luck, an RTC returning 01/01/1970 will get mapped to January 19th,
2038, and hence give the correct date.

      Andrew
 
