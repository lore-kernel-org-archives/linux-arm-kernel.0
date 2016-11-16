From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Nov 2016 16:06:28 +0100
Subject: [PATCH net 1/3] net: phy: realtek: add eee advertisement disable
 options
In-Reply-To: <1479307890.17538.40.camel@baylibre.com>
References: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
 <1479220154-25851-2-git-send-email-jbrunet@baylibre.com>
 <20161115163036.GB23231@lunn.ch>
 <476b72f3-5efe-3551-6c24-0e378d655a0f@gmail.com>
 <1479290189.17538.25.camel@baylibre.com>
 <20161116132337.GD19962@lunn.ch>
 <1479307890.17538.40.camel@baylibre.com>
Message-ID: <20161116150628.GI23231@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 03:51:30PM +0100, Jerome Brunet wrote:
> On Wed, 2016-11-16 at 14:23 +0100, Andrew Lunn wrote:
> > > 
> > > There two kind of PHYs supporting eee, the one advertising eee by
> > > default (like realtek) and the one not advertising it (like
> > > micrel).
> 
> This is just the default register value.
> 
> > 
> > I don't know too much about EEE. So maybe a dumb question. Does the
> > MAC need to be involved? Or is it just the PHY?
> > 
> > If the MAC needs to be involved, the PHY should not be advertising
> > EEE
> > unless the MAC asks for it by calling phy_init_eee(). If this is
> > true,
> > maybe we need to change the realtek driver, and others in that class.
> 
> As far I understand, the advertised capabilities are exchanged during
> the auto-negotiation.
> 
> At this stage, if the advertisement is disabled (regarless of the
> actual support) on either side of the link, there will be no low power
> idle state on the Tx nor the Rx path.
> 
> If the advertisement is enabled on both side but we don't call
> phy_init_eee, I suppose Tx won't enter LPI, but Rx could.

What i was trying to find out is, if the MAC needs to support EEE as
well as the PHY, what happens when the MAC does not support EEE, but
the PHYs do negotiate EEE? Does it break?

    Andrew
