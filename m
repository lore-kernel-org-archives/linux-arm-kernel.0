From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 22:01:28 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <201210242006.55879.michael@walle.cc>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc>
Message-ID: <20121024200128.GY21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 08:06:55PM +0200, Michael Walle wrote:
> Hi Andrew,
> 
> Am Mittwoch 24 Oktober 2012, 16:53:45 schrieb Andrew Lunn:
> > This patchset converts all DT kirkwood boards to using pinctrl.
> > 
> > This patchset depends on an earlier patchset to allow the mvebu
> > pinctrl driver and gpio driver to be built for kirkwood.
> > 
> > Only the TS219 conversion has been tested on hardware. The remaining
> > are compile tested. Before merging upstream, it would be good if the
> > others could be tested on hardware.
> > 
> > This series along with the dependents can be found in:
> 
> Unfortunately, this doesn't work for me. git bisect tells me its commit 
> e01139ec82162f21875d09e820686aede4219695.
> 
> I guess it has something to do with the lsxl_init calling gpio_set_value().

Humm.

I guess it is too early to use gpio. I don't think the gpio driver has
not been configured yet.

I need to think about this.

What happens if you comment out these two gpio_set_value calls?

     Andrew
