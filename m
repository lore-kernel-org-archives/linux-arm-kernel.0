From: rric@kernel.org (Robert Richter)
Date: Tue, 16 Feb 2016 15:42:50 +0100
Subject: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <20160215183041.GH3965@htj.duckdns.org>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org>
 <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
Message-ID: <20160216144250.GD31343@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.02.16 13:30:41, Tejun Heo wrote:
> On Sun, Feb 14, 2016 at 07:36:18PM -0800, Tirumalesh Chalamarla wrote:
> > There is no need for special Driver, AHCI is sufficient for ThunderX, the
> > file only contains this interrupt handler,
> > is it preferable if this interrupt handler in libahci.c with others, instead
> > of separate file?
> 
> Yeap, just fold it in ahci.c with surrounding #ifdef guard.

Yes, please use #ifdef CONFIG_CAVIUM_ERRATUM_22536 ... and add a
kconfig entry for this to arch/arm64/Kconfig.

-Robert
