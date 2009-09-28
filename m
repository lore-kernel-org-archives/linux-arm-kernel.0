From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 28 Sep 2009 11:52:38 +0200
Subject: [PATCH 2/2] n2100: reduce power button timer to 1 Hz
In-Reply-To: <19134.29011.460366.960746@pilspetsen.it.uu.se>
References: <19134.29011.460366.960746@pilspetsen.it.uu.se>
Message-ID: <20090928095238.GI1773@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 26, 2009 at 09:53:55PM +0200, Mikael Pettersson wrote:

> The power button on the n2100 apparently does not generate
> an interrupt when pressed, so the board support code sets
> up a periodic timer to sample it.
> 
> This timer operates at 10 Hz, which makes it the third worst
> cause of timeouts in my kernel when idle.
> 
> 10 Hz seems excessive, so this patch adds a compile-time option
> to reduce the polling frequency to 1 Hz.

How much power does this actually save?
