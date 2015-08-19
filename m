From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 19 Aug 2015 08:56:48 +0200
Subject: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver
 driver
In-Reply-To: <1463451.tH10lfH9Hm@phil>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <1463451.tH10lfH9Hm@phil>
Message-ID: <1439967408.4135.84.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Heiko,

Thanks for the comments, i'm hoping to address them and Marks comments
in a next patch series next week.

On Tue, 2015-08-18 at 20:25 +0200, Heiko Stuebner wrote:

> > +
> > +     spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");

> I guess this could be named just "hclk" - as it is the identifier 
> local to the spdif-ip. (Of course in the binding too)

I'm entirely happy to change that, just wanted to note that the reason
i used spdif_hclk and spidf_clk is for consistency with the rockchip
-i2s binding which uses i2s_hclk ans i2s_mclk. 

However i guess we could update the i2s binding at some poit as well to
follow similar names (with fallbacks to the old one). In general a lot
of the comments yourself and Mark have given actually apply to the
rockchip-i2s code as well so there is some cleanup to do there :)

-- 
Sjoerd Simons
Collabora Ltd.
