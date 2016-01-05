From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Tue, 5 Jan 2016 12:37:50 +0100
Subject: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
In-Reply-To: <50067860.qzAxcgo8L4@wuerfel>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20151224190237.GA17343@pali> <5681A322.2090204@gmail.com>
 <50067860.qzAxcgo8L4@wuerfel>
Message-ID: <20160105113750.GL22661@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 December 2015 23:27:17 Arnd Bergmann wrote:
> On Monday 28 December 2015 13:01:22 Frank Rowand wrote:
> > 
> > Patch 2/5 copies the value from ATAG_REVISION into the fdt "/revision"
> > property.
> > 
> > If the use of /revision is limited to being a location to hold an ATAG
> > value to pass to the global variable system_rev, then it would make
> > sense to just copy directly from the ATAG value into system_rev in the
> > same board file where you are copying the ATAGs.
> 
> Agreed. That would be simpler, and avoid a situation where someone relies
> on the /revision property in DT to be set from the atags compat code
> (preventing an upgrade to a newer bootloader), or on the system_rev variable
> to be the same across multiple boot loaders, in the absence of other
> kernel code setting it.

So, set system_rev only for Nokia N900? At same place where is called
save_atags()?

-- 
Pali Roh?r
pali.rohar at gmail.com
