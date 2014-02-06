From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Feb 2014 17:50:03 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <1391704765.2162.7.camel@kazak.uk.xensource.com>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-5-git-send-email-andrew@lunn.ch>
 <20140206153939.GD8533@titan.lakedaemon.net>
 <1391704765.2162.7.camel@kazak.uk.xensource.com>
Message-ID: <20140206165003.GJ29860@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 04:39:25PM +0000, Ian Campbell wrote:
> On Thu, 2014-02-06 at 10:39 -0500, Jason Cooper wrote:
> > 
> > > +                     pmx_fan_33: pmx-fan-33 {
> > > +                             marvell,pins = "mpp33";
> > > +                             marvell,function = "gpo";
> > > +                     }; 
> 
> Typo I think.

Hi Ian

drivers/pinctrl/mvebu/pinctrl-kirkwood.c:

        MPP_MODE(33,
                MPP_VAR_FUNCTION(0x0, "gpo", NULL,       V(0, 1, 1, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x2, "tdm", "dtx",      V(0, 0, 1, 1, 1, 0)),
                MPP_VAR_FUNCTION(0x3, "ge1", "txctl",    V(0, 1, 1, 1, 1, 0)),
                MPP_VAR_FUNCTION(0xb, "lcd", "d13",      V(0, 0, 0, 0, 1, 0))),
        MPP_MODE(34,

It is output only.

I actually had the opposite bug in v1, setup two gpo's as gpio's.

  Andrew
