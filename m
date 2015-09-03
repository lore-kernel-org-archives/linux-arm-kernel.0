From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Sep 2015 09:08:06 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150903093910.GA4151@ulmo.nvidia.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
 <20150903093910.GA4151@ulmo.nvidia.com>
Message-ID: <CAD=FV=UOSFeKPHSQE1Mrc_d4yCu54LOTj+TRZc_+kPs1mofLxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

On Thu, Sep 3, 2015 at 2:39 AM, Thierry Reding <treding@nvidia.com> wrote:
> Perhaps the I2C core needs to be taught to look at the adapter's
> ->dev.parent->of_node in of_find_i2c_adapter_by_node(). As I understand
> it the purpose for registering a separate struct device for each I2C
> controller is so that there's an I2C parent for all slaves. At the same
> time every controller sets up ->dev.parent, and that parent's OF node is
> what we really want when we look up an I2C adapter by OF node. In other
> words, the OF node by which I2C adapters are referenced is always that
> of its parent device, as far as I can tell.
>
> Wolfram, do you know of any cases where adapter->dev.of_node would not
> be the same as adapter->dev.parent->of_node?

This sounds pretty reasonable to me.  Certainly it would be a pretty
reasonable fallback if adapter->dev.of_node was NULL.

-Doug
