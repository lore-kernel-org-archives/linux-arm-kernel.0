From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Mar 2011 02:03:50 -0600
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
In-Reply-To: <20110315075231.GH11098@S2100-06.ap.freescale.net>
References: <20110309215800.26377.43925.stgit@riker>
	<20110315034421.GE11098@S2100-06.ap.freescale.net>
	<20110315075231.GH11098@S2100-06.ap.freescale.net>
Message-ID: <20110315080350.GN23050@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 03:52:32PM +0800, Shawn Guo wrote:
> On Tue, Mar 15, 2011 at 11:44:22AM +0800, Shawn Guo wrote:
> > On Wed, Mar 09, 2011 at 01:58:00PM -0800, John Bonesio wrote:
> > > This patch provides the ability to boot using a device tree that is appended
> > > to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> > > 
> > > Signed-off-by: John Bonesio <bones@secretlab.ca>
> > > ---
> > > 
> > >  arch/arm/Kconfig                |    7 ++++
> > >  arch/arm/boot/compressed/head.S |   75 +++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 79 insertions(+), 3 deletions(-)
> > > 
> > I played this patch on mx51 babbage a little bit, and noticed that it
> > introduces one difference on both non-dt and dt kernel booting.  The
> 
> To be clear, the difference is being seen when I do not even enable
> CONFIG_ARM_APPENDED_DTB.

That would definitely be a bug then.

g.
