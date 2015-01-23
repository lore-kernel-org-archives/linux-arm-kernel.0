From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Jan 2015 13:22:56 +0900
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Introduce multiplatform
 support
In-Reply-To: <20150122025002.GA12687@verge.net.au>
References: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
 <20150113020811.GA21265@verge.net.au>
 <20150122024804.GF31170@verge.net.au>
 <20150122025002.GA12687@verge.net.au>
Message-ID: <20150123042255.GC17548@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:50:03AM +0900, Simon Horman wrote:
> On Thu, Jan 22, 2015 at 11:48:05AM +0900, Simon Horman wrote:
> > On Tue, Jan 13, 2015 at 11:08:14AM +0900, Simon Horman wrote:
> > > On Fri, Jan 09, 2015 at 02:08:48PM +0100, Geert Uytterhoeven wrote:
> > > > 	Hi Simon, Magnus,
> > > > 
> > > > This patch series (by Magnus) introduces multiplatform support for the
> > > > sh73a0 platform. After this kzm9g can boot a sh73a0 multiplatform
> > > > kernel fine, except for working Ethernet (the ZB clock is disabled by
> > > > clk_disable_unused()).
> > > > 
> > > > This series has been sent before by Magnus as part of the series
> > > > "[PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform
> > > > revisit" (http://www.spinics.net/lists/linux-sh/msg38384.html).
> > > > I've updated the kzm9g DTS sync patch for recent changes to the
> > > > kzm9g-reference DTS.
> > > > 
> > > > Thanks for applying!
> > > 
> > > Thanks, done.
> > 
> > For the record: Olof has asked for review comments for the BSC driver
> > and binding patches. Accordingly I have dropped them, and these patches
> > which depend on them, from next.
> 
> To clarify, this dependency may be due to the way the branches are arranged,
> rather than actual dependencies of the code. But regardless I am dropping
> all effected branches for now.

I have now had a chance to re-examine these patches and it seems to me that
they do not depend on the BSC driver (or anything else other than for
context). With that in mind I have queued them up in the
sh73a0-multiplatform-for-v3.21 which is based on the dt-for-v3.21 branch
(for context) as part of and pushed this as part of
renesas-devel-20150123-v3.19-rc5.

Please take a moment to see if what I have done makes sense to you.

For reference this covers the following patches which comprised this series:

Magnus Damm (4):
  ARM: shmobile: sh73a0: Introduce generic setup callback
  ARM: shmobile: sh73a0: Add Multiplatform support
  ARM: shmobile: kzm9g dts: Sync with kzm9g-reference dts
  ARM: shmobile: kzm9g: Build DTS for Multiplatform
