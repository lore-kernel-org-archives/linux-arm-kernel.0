From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Nov 2012 07:24:03 -0500
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <20121126113506.06c431cd@skate>
References: <pull-1353733874-990435> <20121126091652.GA13866@quad.lixom.net>
 <20121126102805.5337f7f5@skate> <201211261028.26334.arnd@arndb.de>
 <20121126113506.06c431cd@skate>
Message-ID: <20121126122403.GX15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 11:35:06AM +0100, Thomas Petazzoni wrote:
> Note that I am also surprised by the fact that we had to remove a
> 'clocks=' property in dove.dtsi, and therefore have a known-broken
> 3.8-rc1 even before it is released. It sounds strange to me that the
> separation of branches prevents from doing the correct changes. But
> maybe I'm not seeing the entire problem, and therefore under-estimating
> the issues at hand.

When I removed this, I thought it was an accidental line left over from
some clock work Sebastian was working on.  Primarily because it was the
*only* reference to clock in that series.  It was only later that I
found out it should have depended on mvebu/everything (or a subset of
it).

In an ideal world, we won't have to do an mvebu/everything, and then
it's a lot easier to get all the dependencies correct.

At any rate, as Sebastian noted, it builds fine, it boots, and only
hangs if you query the cooresponding debugfs element.  Not ideal, for
sure, but easily fixed in -rc1.

thx,

Jason.
