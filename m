From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 13 May 2014 14:07:51 +0200
Subject: [PATCH v2 3/6] ata: ahci: add AHCI support for the Berlin BG2Q
In-Reply-To: <20140512141221.GE3378@lunn.ch>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140512141221.GE3378@lunn.ch>
Message-ID: <20140513120751.GA3213@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, May 12, 2014 at 04:12:21PM +0200, Andrew Lunn wrote:
> On Mon, May 12, 2014 at 11:16:54AM +0200, Antoine T?nart wrote:

[?]

> I've no idea is this is a good or bad idea, but could you put all the
> above code in the phy driver? It does seem to be mostly phy
> related. Then teach the core ahci code about optional phy nodes in DT.
> You can then probably do without a ahci berlin driver.

The code is PHY related, but the setup done is SATA specific. I think it
makes sense to keep it here. From what I saw lots of PHY drivers only
power up / down the PHYs.

Lots of port setups are done in the SATA framework, so it would separate
related code into two subsystems.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
