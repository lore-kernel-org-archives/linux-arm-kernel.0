From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Nov 2015 16:15:19 +0100
Subject: [RFC] ASoC: Add mediatek HDMI codec driver
In-Reply-To: <20151104120343.GZ20228@sirena.org.uk>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
 <20151104120343.GZ20228@sirena.org.uk>
Message-ID: <1446736519.3894.113.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Mittwoch, den 04.11.2015, 12:03 +0000 schrieb Mark Brown:
> On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:
> 
> > This driver is based on the work of DW HDMI codec driver.
> > It controls mediatek HDMI Tx's audio module, and handles
> > HDMI jack detection by sharing IRQ with HDMI Tx.
> 
> How does this relate to all the other HDMI related work that's going on,
> especially around handling of the EDID data?  I'm not seeing anything in
> here that uses the constraints code that Russell added for example. 

So I'll use snd_pcm_hw_constraint_eld.

> As I keep saying I really want to see some collaboration and consensus
> here with the goal of sharing code and achieving a consistent userspace
> interface rather than a lot of individual independently implemented
> drivers.

For eld updates and jack handling I could try to go forward with
Russell's notification prototype from the "[RFC,V2,0/5] another generic
audio hdmi codec proposal" thread:
https://patchwork.kernel.org/patch/7339011/

Or are you saying there shouldn't be a Mediatek specific HDMI sound
driver at all and this should be handled by generic code?

regards
Philipp
