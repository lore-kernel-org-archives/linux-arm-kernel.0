From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2017 09:32:28 +0000
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170107093228.GI14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 05:46:17PM +0100, Thomas Petazzoni wrote:
> @@ -31,7 +43,7 @@ Optional properties (port):
>    then fixed link is assumed, and the 'fixed-link' property is
>    mandatory.

Not directly related to this patch, but this context is wrong.  The
PP2 driver _requires_ a PHY.  It doesn't support fixed-link in its
current form.  I think the DT binding describes an expectation of
a future driver.

The side effect is that if trying to use a fixed-link on any port,
the ethernet driver fails to probe.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
