From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Feb 2011 07:29:11 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <4D62C237.1020803@bluewatersys.com>
References: <1298256658.862488.956979497586.2.gpush@pororo>
	<4D62C237.1020803@bluewatersys.com>
Message-ID: <201102220729.13708.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

> If we never need to dynamically create fixed clocks (which seems
> unlikely) then rate can be const.

There's been a few cases where I've needed to set the rate of a fixed clock 
during boot - for example when a clock rate varies between boards, it may be 
defined in a platform-wide file, but have the rate modified early (ie, 
clk_foo.rate = 32678) in a board file.

Also, if we're parsing clocks from the device tree (or any other discovery 
mechanism), we'll need to modify rate.

Cheers,


Jeremy
