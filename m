From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jun 2014 00:35:27 +0200
Subject: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
In-Reply-To: <53A03186.3040703@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
Message-ID: <20140617223518.GA25309@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 02:16:06PM +0200, Tomeu Vizoso wrote:
> On 06/16/2014 10:02 PM, Stephen Warren wrote:
> >On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> >>+
> >>+Child device nodes describe the memory settings for different configurations and
> >>+clock rates.
> >
> >How do the child nodes do that? The binding needs to specify the format
> >of the child node.
> 
> Sorry, that file was sent before I had finished removing the bits from
> downstream that aren't needed yet. There's no current need for any child
> nodes.
> 
> >This binding looks quite anaemic vs.
> >Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
> >would expect that this binding needs all the EMC register data from the
> >tegra20-emc binding too. Can the two bindings be identical?
> 
> There's even less stuff needed right now, as all what ultimately the EMC
> driver does is call clk_set_rate on the EMC clock. As the T124 EMC driver
> gains more features, they should get more similar.
> 
> >Can you explain what the nvidia,mc and nvidia,pmc references are needed
> >for? Hopefully, this driver isn't going to reach into those devices and
> >touch their registers directly.
> 
> Not really needed, see above.

I've been working on a prototype driver for the memory controller. Part
of what I've added is programming of the latency allowance registers (it
doesn't yet expose an API to do so yet, though). I think that needs to
eventually take into account the EMC frequency (and needs to be notified
of changes to the same).

Without having thought this through very thoroughly, I suspect that
rather than referencing the MC from the EMC it might be better to have
the MC register with the EMC for notifications.

But perhaps there are other services from MC that EMC needs to work?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/17d8567e/attachment.sig>
