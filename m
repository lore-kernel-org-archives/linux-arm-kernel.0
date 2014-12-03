From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Dec 2014 16:49:52 +0000
Subject: [PATCH] ARM: rockchip: Convert resume code to C
In-Reply-To: <CAD=FV=Vn_U6YWFN-hruWcYo-HSHt9=hwduEv32Bb5aP_hzNB8Q@mail.gmail.com>
References: <1417461694-5129-1-git-send-email-dianders@chromium.org>
 <20141201225057.GA11285@n2100.arm.linux.org.uk>
 <CAD=FV=VT7gr504-ZgWPfha+40XDX5eShkzZ36bg=-4Oub1S27w@mail.gmail.com>
 <25485084.A6ydfR9Xle@wuerfel>
 <CAD=FV=UFWZEcbO2ty0m+qEGv4Xgq0N=Rs30wBgw=6+OGd5gSpg@mail.gmail.com>
 <CACRpkdapVhrQe7n5wDzZbf3fYGGpB-jPzG8Z+A8X6j5ERLxAfg@mail.gmail.com>
 <CAD=FV=Vn_U6YWFN-hruWcYo-HSHt9=hwduEv32Bb5aP_hzNB8Q@mail.gmail.com>
Message-ID: <20141203164951.GI11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 08:44:55AM -0800, Doug Anderson wrote:
> Sure.  I look forward to someone solving it.  ...and as I said, until
> someone does solve it I think we're blocked from landing deep sleep
> mode for rk3288 upstream (unless someone decides that my patches are
> OK).

What we definitely don't want to do is to have each SoC doing their
own thing on this, so we really need it to either be generic across
all ARMs, or fully generic.

So, if it can be turned into some kind of generic infrastructure, I'd
be happier with it, because that would help it be re-used across other
SoCs.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
