From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Aug 2017 15:37:51 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827091301.wbuzxkh7opz4blrc@piout.net>
 <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
Message-ID: <20170827133751.GD13622@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static inline int rtd119x_rtc_year_days(int year)
> >> +{
> >> +	return rtc_year_days(1, 12, year);
> > 
> > I'm not sure it is worth wrapping rtc_year_days
> [snip]
> 
> Well, I found your rtc_year_days rather confusing and had to play with
> the arguments until I got it working as expected, so I wanted an inline
> function (or macro) as abstraction from my three callers.

I agree with that. I was wondering why 1st December was being used. I
would say this API does not do too well on Rusty's API Design
Manifesto.

It does at least get the day/month/year in the right order ;-)

	Andrew
