From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 07:13:13 -0400
Subject: [PATCH v2 7/9] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <20130827103907.0030c970@skate>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377295942-5955-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130826140843.GI13964@titan.lakedaemon.net>
 <20130827083603.GA2286@localhost> <20130827103907.0030c970@skate>
Message-ID: <20130827111313.GB19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:39:07AM +0200, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Tue, 27 Aug 2013 05:36:04 -0300, Ezequiel Garcia wrote:
> 
> > > Is there a reason we're going this route over adding a new compatible
> > > string?
> > 
> > Well, it seemed to me that this register splitting was more device-treeish:
> > it prevents you from fixing your driver, adding a new compatible-string,
> > and rebuilding a kernel each time a new SoC appears with a different offset
> > between registers.
> 
> I don't think encoding register offsets in the DT is a good idea. The
> compatible string is here to identify different revisions/versions of
> the same hardware block, and the driver should abstract out the
> details. Otherwise, you'll start encoding bit numbers, mask values, and
> other crazy things in the Device Tree.

Agreed.  DT is for describing how the hardware is wired together on a
specific board.  The compatible strings should tell you which variant of
an IP block you have.  The information you're trying to encode doesn't
belong in the DT, it should be in the driver.

As an added bonus, by doing so, you avoid breaking compatibility. ;-)

thx,

Jason.
