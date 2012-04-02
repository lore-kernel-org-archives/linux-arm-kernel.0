From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 2 Apr 2012 10:37:49 +0200
Subject: [PATCH v5 09/16] pwm: tegra: Add device tree support
In-Reply-To: <4F7602CD.2010808@wwwdotorg.org>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-10-git-send-email-thierry.reding@avionic-design.de>
 <4F7602CD.2010808@wwwdotorg.org>
Message-ID: <20120402083749.GA6576@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/28/2012 08:33 AM, Thierry Reding wrote:
> > Add auxdata to instantiate the PWFM controller from a device tree,
> > include the corresponding nodes in the dtsi files for Tegra 20 and
> > Tegra 30 and add binding documentation.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> ...
> > +#ifdef CONFIG_OF
> > +static struct of_device_id tegra_pwm_of_match[] = {
> > +	{ .compatible = "nvidia,tegra20-pwm" },
> > +	{ .compatible = "nvidia,tegra30-pwm" },
> 
> Could you swap those two lines, so that tegra30-pwm matches first. It
> makes no difference at present, but might in the future if the driver
> actually has to differentiate the two SoCs.

I thought the matching order was determined by the compatible property in the
device tree, not the OF match table of the driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/066b6c5d/attachment.sig>
