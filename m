From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 9 Dec 2010 10:16:53 +0800
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <4CFFB6DD.4000108@fluff.org>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<201012080902.37859.jeremy.kerr@canonical.com>
	<4CFFB6DD.4000108@fluff.org>
Message-ID: <201012091016.54130.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> Why do they need atomic clocks?

Some of the clocks need enabling/disabling at interrupt time, and apparently 
can't be deferred to a non-atomic context. You'd have to query them for more 
details though, this is all I know at this stage.

> This is starting to look like a real mess.

The only external change this brings is that the clock driver uses 
INIT_CLK_ATOMIC rather than INIT_CLK.

Cheers,


Jeremy
