From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 21:12:07 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <201409252112.07513.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014, Antoine Tenart wrote:
> +static int ci_hdrc_usb2_dt_probe(struct device *dev,
> +                                struct ci_hdrc_platform_data *ci_pdata)
> +{
> +       ci_pdata->phy = of_phy_get(dev->of_node, 0);

FWIW, I accidentally built a kernel with this driver enabled and got a warning
for this code. The problem is that ci_pdata->phy is a 'struct usb_phy' pointer,
while of_phy_get() returns a generic 'struct phy'. While the two have similar
behavior, they are not the same thing and this can't work.

	Arnd
