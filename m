From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 28 Sep 2009 12:25:34 +0200
Subject: [PATCH 2/2] n2100: reduce power button timer to 1 Hz
In-Reply-To: <20090928095238.GI1773@mail.wantstofly.org>
References: <19134.29011.460366.960746@pilspetsen.it.uu.se>
	<20090928095238.GI1773@mail.wantstofly.org>
Message-ID: <19136.36638.111627.2242@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lennert Buytenhek writes:
 > On Sat, Sep 26, 2009 at 09:53:55PM +0200, Mikael Pettersson wrote:
 > 
 > > The power button on the n2100 apparently does not generate
 > > an interrupt when pressed, so the board support code sets
 > > up a periodic timer to sample it.
 > > 
 > > This timer operates at 10 Hz, which makes it the third worst
 > > cause of timeouts in my kernel when idle.
 > > 
 > > 10 Hz seems excessive, so this patch adds a compile-time option
 > > to reduce the polling frequency to 1 Hz.
 > 
 > How much power does this actually save?

I have no way of measuring that, unfortunately.
