From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 25 Feb 2015 09:27:36 -0800
Subject: [PATCH V6 00/12] Tegra xHCI support
In-Reply-To: <20150225160110.GA26610@ulmo>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
 <20150225160110.GA26610@ulmo>
Message-ID: <CAL1qeaEmSphLd=k3f6865OEO_rcwO3+Hv5KDvCN2_=7nDdZJzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

> Sorry for taking so awfully long to look at this. I've spent some time
> looking at various pieces of documentation and I concluded that
> representing the port assignment as muxing options doesn't seem right
> after all. Instead I've come up with an alternate proposal (attached).
> Could you take a look and see if that sounds reasonable to you?

Thanks for taking a look at this.  I've been meaning to pick this
series back up, but haven't had quite enough bandwidth lately.

This all looks good to me, just one comment below:

> +PHY nodes:
> +----------
> +
> +An optional child node named "phys" can contain nodes describing additional
> +properties of each PHY. Only USB3 and UTMI PHYs can be complemented in this
> +way, in which case the name of each node must match one of the following:
> +
> +  usb3-0, usb3-1, utmi-0, utmi-1, utmi-2
> +
> +Required properties for USB3 PHYs:
> +- nvidia,lanes: specifies the name of the lane that this USB3 PHY uses
> +- nvidia,port: specifies the number of the USB2 port that is used for this
> +  USB3 PHY
> +
> +Optional properties for UTMI PHYs:
> +- vbus-supply: regulator providing the VBUS voltage for the UTMI pad

What about the HSIC PHYs?  Shouldn't they be represented as PHY nodes as well?
