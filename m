From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2015 10:56:33 +0100
Subject: bcm4708-smartrg-sr400ac boot failures in next-20150918+
In-Reply-To: <1444816125.13276.8.camel@pengutronix.de>
References: <CANMBJr5FnRQxv01CbAiSD43dGn+Ea4tjEWSsV1FywHJZYLnG_A@mail.gmail.com>
 <560DA9B9.80404@hauke-m.de> <561AE788.6030701@hauke-m.de>
 <CANMBJr4H1C6CHdRXa_NL9dssYGLkpRKAPXCMOV0FsUdb8JiSXg@mail.gmail.com>
 <1444816125.13276.8.camel@pengutronix.de>
Message-ID: <20151014095633.GP32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:48:45AM +0200, Lucas Stach wrote:
> I think we really want to keep enabling the imprecise aborts as early as
> possible to catch them near the spot where they did happen.

Agreed.

> So I think the right thing to work around your broken bootloader is to
> install the fault handler earlier. Russell, do you have any objections
> to that?

How about installing the fault handler early before enabling the imprecise
aborts, and have the fault handler print a complaint about the broken
boot loader, and have the fault handler uninstall itself after the
imprecise abort has been enabled?

If there's a pending imprecise abort, it should be delivered as soon as
they're unmasked.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
