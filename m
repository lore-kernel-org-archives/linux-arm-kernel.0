From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Feb 2014 10:43:41 -0500
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.14
In-Reply-To: <20140219002446.GD25055@quad.lixom.net>
References: <20140218161102.GT7862@titan.lakedaemon.net>
 <20140219002446.GD25055@quad.lixom.net>
Message-ID: <20140219154341.GK7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 04:24:46PM -0800, Olof Johansson wrote:
> On Tue, Feb 18, 2014 at 11:11:02AM -0500, Jason Cooper wrote:
> > All,
> > 
> > I've been sitting on the missing alias for a while waiting for more DT
> > fixes to show up.  Well, finally one did. :(
> > 
> > Please pull for v3.14.
> > 
> > I intend to re-add the dove PMU node once I know for certain the
> > corresponding driver is going in to v3.15 (pull request already sent).
> 
> I've pulled this, but:
> 
> > Jason Cooper (1):
> >       ARM: dove: dt: revert PMU interrupt controller node
> 
> Hmm. Seems like my dove machine (cubox) still booted. This does fix the
> boot time warning though.

ok, this was a compound error on my part.  The reported WARN_ON kernel
logs stopped after the WARN_ON output.  I assumed the board hung at that
point.  Second, I've been too focused on the d*mn phy failures in the
bootfarm I haven't even looked at the cubox booting successfully.

At any rate, it does remove the warning for v3.14, and the driver is
slated for v3.15, So I'll re-add the node for v3.15.

Unfortunately, this creates a dependency on mvebu/dt-fixes by mvebu/dt.
Or, I could just add the node to fixes-non-critical for v3.15 to avoid
the dependency.  Which do you prefer?

thx,

Jason.
