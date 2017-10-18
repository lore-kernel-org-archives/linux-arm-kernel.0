From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 18 Oct 2017 09:27:50 +0200
Subject: [PATCH] firmware: meson-sm: use generic compatible
In-Reply-To: <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
References: <20171012134743.10625-1-jbrunet@baylibre.com>
 <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
Message-ID: <1508311670.3957.29.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-17 at 15:50 -0500, Rob Herring wrote:
> On Thu, Oct 12, 2017 at 03:47:43PM +0200, Jerome Brunet wrote:
> > The meson secure monitor seems to be compatible with more SoCs than
> > initially thought. Let's use the most generic compatible he have in
> > DT instead of the gxbb specific one
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4 ++--
> >  drivers/firmware/meson/meson_sm.c                             | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Seems like a pointless, not backwards compatible 

The related DTS have both the SoC family compatible and the SoC specific
compatible. So it is backward compatible (even if this contraints is relaxed on
meson because we are figuring out what is shared between SoCs)

We are asked to put SoC family and SoC specific compatibles in DTS. What's the
point of that if we are going to match on whatever was there first ?

> change to me. In the 
> end, it's just a string to match on. Who cares what the string is.
> 

The matched string has to keep some sort of logic to be maintainable.
It should be clear what the data (or the absence of data) attached to a string
relates to. 

If we really don't care what the string is, we could pick words at random in the
dictionary ... it would be chaos, but at least it would not be confusing 

> Rob
