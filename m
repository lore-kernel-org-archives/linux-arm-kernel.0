From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Aug 2014 09:08:08 +0100
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <20140818062532.GC2114@dragon>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
 <20140818062532.GC2114@dragon>
Message-ID: <20140819080808.GB30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 02:25:34PM +0800, Shawn Guo wrote:
> On Fri, Jul 25, 2014 at 02:20:40PM +0800, Shawn Guo wrote:
> > HDMI currently stops working after a system suspend/resume cycle.  The
> > cause is that the mode setting states in hardware gets lost and isn't
> > restored across the suspend/resume cycle.
> > 
> > The patch adds a very basic suspend/resume support to imx-drm driver,
> > and calls drm_helper_resume_force_mode() in .resume hook to restore the
> > mode setting states, so that HDMI can continue working after a system
> > suspend/resume cycle.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Hi Russell,
> 
> What's your take on this patch?

I've mostly stepped away from collecting imx-drm patches for Greg, and
I'm probably going to be dropping those patches which I had queued up
a while back for Greg.

Greg wishes me to use signed tags for pull requests.  This is not how I
work, and would mean having to rewrite a bunch of my scripts to cater
for Greg's special case.  No one else requires this.

I haven't had the time to start looking at what this would require
during the last three months, so the only other solution is to step
down from dealing with imx-drm patches.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
