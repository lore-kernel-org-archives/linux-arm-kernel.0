From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Apr 2014 11:36:52 +0200
Subject: [PATCH 2/2] net: mvneta: fix usage as a module on RGMII
 configurations
In-Reply-To: <533C1B75.2020803@free-electrons.com>
References: <1395789942-20764-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395789942-20764-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <533C1B75.2020803@free-electrons.com>
Message-ID: <20140403113652.33f11413@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 02 Apr 2014 16:15:17 +0200, Gregory CLEMENT wrote:

> > This commit was successfully tested with mvneta compiled as a module,
> > on both the OpenBlocks AX3 (SGMII configuration) and the Armada XP GP
> > (RGMII configuration).
> 
> Unfortunately with this patch, mvneta doesn't work anymore on the
> Mirabox (Armada 370 based board) on 3.14.I didn't managed to do a
> simple ping.
> 
> Once I removed this commit then the driver worked again.

Problem reproduced. It turns out that some RGMII platforms need the
PCS_ENABLE bit to be set (e.g: Armada XP GP), while some other
platforms need the PCS_ENABLE bit to be cleared (e.g: Armada 370
Mirabox). I've verified that on both platforms.

I've asked for more details about this bit to understand in which
situation it should be set or cleared. I'll get back to you with an
updated patch once I have enough information to write a fix.

Thanks for the report,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
