From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Oct 2017 14:40:27 +0200
Subject: [PATCH v2 0/3] pinctrl: sunxi: Start to enforce the strict mode
In-Reply-To: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171025124027.oosswpymrwkvcvxx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Oct 09, 2017 at 10:53:36PM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here is an attempt to enable pinctrl's strict mode on our pinctrl drivers.
> Indeed, our controllers should have had that mode enabled since its
> introduction.
> 
> However, there's a number of issues with old device trees that prevent from
> just enabling it for all the devices. There's basically two of them:
> 
>   - Most of our old DTs have a pinctrl node for GPIOs, which will result in
>     an error when the driver is going to request the gpio because it would
>     already be requested automatically by pinctrl. We cannot break those.
> 
>   - Some of these GPIOs also need to change their pin configuration to add
>     a bias or change the current output, and there isn't a migration path.
> 
> Let's just keep the old behaviour for the old SoCs, and enforce it on the
> new one, and enabled it by default so that the situation at least doesn't
> get worse.
> 
> This has been tested on an A83t (strict on) and an H3 (strict off) board.

Did you have some time to look at this?

The earlier we merge it the better, so ideally I'd really like to get
this into 4.15.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171025/b282be95/attachment.sig>
