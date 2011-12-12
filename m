From: noodles@earth.li (Jonathan McDowell)
Date: Sun, 11 Dec 2011 21:00:22 -0800
Subject: [PATCH 00/10] ARM: OMAP1: ams-delta: replace custom I/O with GPIO
In-Reply-To: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111212050022.GI16333@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 09:11:58PM +0100, Janusz Krzysztofik wrote:
> The Amstrad Delta board has two extra output ports used for driving
> input lines of different on-board devices. Those ports are now
> controlled with custom functions, provided by the board arch code and
> used by several device drivers.
> 
> The idea behind the series is to replace those custom I/O functions
> with gpiolib API. This way, existing drivers can be made less platform
> dependent, and some of them perhaps even superseded with generic GPIO
> based drivers after the board platform device descriptions are
> converted. Moreover, should a new driver for the on-board Smart Card
> controller ever be created, it could be designed as a generic GPIO
> based driver, not a custom one.

Nice work; moving ams-delta over to gpiolib has been on my todo list for
a while (albeit quite low down).

J.

-- 
I just Fedexed my soul to hell. I'm *real* clever.
