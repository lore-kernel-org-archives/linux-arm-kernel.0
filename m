From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jan 2016 12:45:52 +0100
Subject: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
In-Reply-To: <20160105113750.GL22661@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <50067860.qzAxcgo8L4@wuerfel> <20160105113750.GL22661@pali>
Message-ID: <3663322.UyrB2OmX6o@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 12:37:50 Pali Roh?r wrote:
> On Monday 28 December 2015 23:27:17 Arnd Bergmann wrote:
> > On Monday 28 December 2015 13:01:22 Frank Rowand wrote:
> > > 
> > > Patch 2/5 copies the value from ATAG_REVISION into the fdt "/revision"
> > > property.
> > > 
> > > If the use of /revision is limited to being a location to hold an ATAG
> > > value to pass to the global variable system_rev, then it would make
> > > sense to just copy directly from the ATAG value into system_rev in the
> > > same board file where you are copying the ATAGs.
> > 
> > Agreed. That would be simpler, and avoid a situation where someone relies
> > on the /revision property in DT to be set from the atags compat code
> > (preventing an upgrade to a newer bootloader), or on the system_rev variable
> > to be the same across multiple boot loaders, in the absence of other
> > kernel code setting it.
> 
> So, set system_rev only for Nokia N900? At same place where is called
> save_atags()?
> 
> 

Yes.

	Arnd
