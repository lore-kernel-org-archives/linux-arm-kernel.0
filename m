From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Aug 2014 10:42:47 +0100
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <20140819091641.GA1349@kroah.com>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
 <20140818062532.GC2114@dragon>
 <20140819080808.GB30401@n2100.arm.linux.org.uk>
 <20140819091641.GA1349@kroah.com>
Message-ID: <20140819094247.GC30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 04:16:41AM -0500, Greg KH wrote:
> On Tue, Aug 19, 2014 at 09:08:08AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Aug 18, 2014 at 02:25:34PM +0800, Shawn Guo wrote:
> > > On Fri, Jul 25, 2014 at 02:20:40PM +0800, Shawn Guo wrote:
> > > > HDMI currently stops working after a system suspend/resume cycle.  The
> > > > cause is that the mode setting states in hardware gets lost and isn't
> > > > restored across the suspend/resume cycle.
> > > > 
> > > > The patch adds a very basic suspend/resume support to imx-drm driver,
> > > > and calls drm_helper_resume_force_mode() in .resume hook to restore the
> > > > mode setting states, so that HDMI can continue working after a system
> > > > suspend/resume cycle.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > 
> > > Hi Russell,
> > > 
> > > What's your take on this patch?
> > 
> > I've mostly stepped away from collecting imx-drm patches for Greg, and
> > I'm probably going to be dropping those patches which I had queued up
> > a while back for Greg.
> > 
> > Greg wishes me to use signed tags for pull requests.  This is not how I
> > work, and would mean having to rewrite a bunch of my scripts to cater
> > for Greg's special case.  No one else requires this.
> 
> "special case"?  That's what Linus wants from everyone as well, how hard
> is it to add a simple line to your scripts that does:
> 	git tag -u ${KEY} -s ${TREE} ${BRANCH}

Linus is perfectly happy with my pull requests as is.  That's because he
knows their format (which pre-dates git) and it includes protection
against modification of the requested git tree by including the SHA
hash of the top most commit, which was agreed at the time of the
kernel.org break-in as an acceptable alternative approach to signed
tags.

> before doing:
> 	git request-pull .... ${TREE}
> 
> It's just a simple one line addition, right?  What am I missing here?

I don't use git request-pull.  I have my own suite of scripts which
generate a set of formatted patches in mbox format, combined patches,
and the pull request email template, and uploading the appropriate
branches and patches to the server.  They're also more than 10 years
old, which shows how long Linus has been happy with my process.

> You should be using signed tags for your other trees as well, it's not
> just me who should be asking you for this...

You are the only one who has been asking me for it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
