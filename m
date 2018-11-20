From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 20 Nov 2018 01:22:19 +0000
Subject: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
In-Reply-To: <20181117181225.10737-3-andrew.smirnov@gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-3-andrew.smirnov@gmail.com>
Message-ID: <1542676938.30311.581.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
> so none of the code in current implementation of imx6_pcie_reset_phy()
> is applicable.

Tested on IMX7d, still appears to work.

Note that your patches will collide with Stefan Agner's patch, "PCI:
imx6: limit DBI register length", which was recently posted.

He changed the way the variants are handled.  That method would allow
some of the IMX7D || IMX8MQ checks to be re-written as

 imx6_pcie->drvdata->boolean_attribute

Where the attribute can be set in a table and be re-used in every place
it comes into play and updated for new devices in one spot, instead of
keeping piles of this version or that version or this other version
checks up to date.
