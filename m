From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 19:39:57 +0100
Subject: [PATCH 071/222] net:fec: remove unnecessary ip stack includes
In-Reply-To: <CAHrpEqQ_7iWC_mSRPu7b8JmpBQw+NWO2AkMgBawKmhs9fTvZkw@mail.gmail.com>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <E1WdeR9-0007Ht-Tb@rmk-PC.arm.linux.org.uk>
 <CAHrpEqQ_7iWC_mSRPu7b8JmpBQw+NWO2AkMgBawKmhs9fTvZkw@mail.gmail.com>
Message-ID: <20140428183957.GS26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 01:36:44PM -0500, Frank Li wrote:
> On Fri, Apr 25, 2014 at 6:36 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Commit 4c09eed9dc42 (net: fec: Enable imx6 enet checksum acceleration.)
> > added support for hardware checksum support, adding six new includes
> > for things like tcp, udp, ip, icmp, but never made use of anything
> > provided by those header files.  Let's remove this bloat.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Russell
> 
>        I see patches from 71 to 126 are related with fec driver.
>        But maintainer David S. Miller is not in to list.
> 
>        Do you need someone follow up this patches and resent to David
> S Miller till accepted by david? Or you will do it by yourself?

I know they need to re-worked to convert unsigned -> unsigned int before
David sees them, otherwise it'd be an instant review failure.  Doing the
conversion is the easy bit, doing it without hitting the 80 column limit
is much harder...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
