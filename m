From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 8 May 2011 20:46:35 +0200
Subject: [PATCH 03/14] [orion] Consolidate the creation of the RTC
	platform data.
In-Reply-To: <BANLkTikzAv8LJgU4Abjb+DVqbZTdJFi5HQ@mail.gmail.com>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
	<1304864141-1121-4-git-send-email-andrew@lunn.ch>
	<BANLkTikzAv8LJgU4Abjb+DVqbZTdJFi5HQ@mail.gmail.com>
Message-ID: <20110508184635.GE4071@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > ??static void __init kirkwood_rtc_init(void)
> > ??{
> > - ?? ?? ?? platform_device_register_simple("rtc-mv", -1, &kirkwood_rtc_resource, 1);
> > + ?? ?? ?? orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);

> the rtc-mv.c driver enables the alarm support when IRQ resource is
> provided. so this patch actually adds support for rtc alarm, does the
> alarm works for you?

I ran the test code in Documentation/rtc.txt. The alarm interrupt does
work.

> so I suggest to split it to two patches, one consolidates the rtc, and
> the second adds alarm support for KW.

O.K. Will do.

Thanks
	Andrew
