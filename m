From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Nov 2015 17:33:11 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
Message-ID: <20151117173311.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 04:47:12PM -0500, Nicolas Pitre wrote:
> The old method with conditional placement in the linker script is broken 
> beyond repair.  There is simply way too much stuff these days to do this 
> sanely.  I think the only way to fix it properly is to have a separate 
> linker script for XIP usage with proper (and obvious) section placement.

Absolutely the right thing to do.

The XIP stuff has been broken and getting in the way for a long time
now because of the preprocessor mess.  I've made several changes to
the linker script over the years, and each time I've ended up deciding
to I'll do the best job I can for XIP, but I'm not going to spend
too long making sure that it's correct - especially as there appeared
to be no users of it.  I wouldn't describe the current file as being
"maintainable" in any way - It has devolved into a total mess, and I
would like to see the XIP stuff gone from the non-XIP linker script
- and doing that should mean it's less likely for XIP to break.

I'd also like to see a lot more of the preprocessor gunk gone (or at
least cleaned up) in that file too...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
