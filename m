From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 15:18:58 -0500
Subject: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
In-Reply-To: <20141120193804.GA7252@developer>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141120193804.GA7252@developer>
Message-ID: <20141121201858.GB22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 03:38:06PM -0400, Eduardo Valentin wrote:
> Ezequiel and Jason,
> 
> On Sat, Nov 08, 2014 at 10:16:46PM -0500, Jason Cooper wrote:
> > On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> > > The Armada 375 Z1 SoC revision is no longer supported. This commit
> > > removes the quirk needed for the thermal sensor.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
> > >  drivers/thermal/armada_thermal.c                     | 20 --------------------
> > >  2 files changed, 28 deletions(-)
> > 
> > As Thomas and Ezequiel rightfully mentioned, the compatible string below
> > has never been in a dts file.  Our arch code detected the Z1, and
> > changed the compatible on the fly.  As a result, there shouldn't be any
> > dtbs in the wild with this compatible string.  If there are, it will be
> > held by the few developers (Marvell, partners) that know what they are
> > doing.
> 
> First of, I would like to mention that best thing to avoid such
> situation is to be careful when documenting dt entries that represent hw
> that no one has access to (except internal people).

Agreed, mainline support for an SoC so early in it's lifetime was new
for all of us.  Lesson learned.

> > 
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > 
> 
> OK Jason. I saw you picked patch 2. Does it mean I can queue this one? 

Yep.  Take it away.

thx,

Jason.
