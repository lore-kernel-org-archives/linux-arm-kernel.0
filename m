From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 13:25:43 +0100
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <7433994.DUuXUlazW0@wuerfel>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
 <7433994.DUuXUlazW0@wuerfel>
Message-ID: <20140826122542.GL23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 12:32:23PM +0100, Arnd Bergmann wrote:
> On Tuesday 26 August 2014 11:28:49 Punit Agrawal wrote:
> > 
> > This patch ports the alternative solution to emulate the SWP and SWPB
> > instructions using LDXR/STXR sequences from the arm port to
> > arm64. Additionaly, the patch also proivdes support to log the
> > emulation statistics via debugfs.
> 
> I'm not sure that putting this into debugfs is a good idea in this
> case: while in general that is considered a good place for this
> kind of debugging information, we already have a precedent on arm32
> for using procfs, and I see no reason to introduce an incompatible
> interface for arm64.
> 
> You also add an interface for disabling the feature at runtime,
> which we don't have on arm32, but that interface is not available
> if debugfs is disabled or not mounted. Maybe a sysctl would be
> more appropriate? That one could also be shared with arm32.

One advantage of using debugfs is that it provides a place to keep
controls/statistics for any emulations that we add in the future, as opposed
to littering them around in /proc or (worse) having a mixture of the two.

Will
