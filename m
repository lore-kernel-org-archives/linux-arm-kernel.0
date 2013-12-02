From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 10:08:53 +0100
Subject: [PATCH 02/31] ARM: tegra: document reset properties in DT bindings
In-Reply-To: <529B88C9.60804@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
 <20131129122348.GO22771@ulmo.nvidia.com>
 <529B88C9.60804@wwwdotorg.org>
Message-ID: <20131202090852.GD17834@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 12:06:49PM -0700, Stephen Warren wrote:
> On 11/29/2013 05:23 AM, Thierry Reding wrote:
> > On Fri, Nov 15, 2013 at 01:53:57PM -0700, Stephen Warren wrote: 
> > [...]
> >> diff --git
> >> a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
> >> b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
> >
> >> 
> [...]
> >> +  - resets : Must contain an entry for each entry in
> >> reset-names. +    See ../reset/reset.txt for details. +  -
> >> reset-names : Must include the following entries: +    - dc
> > 
> > For consistency with this, the clock-names entry for the first
> > clock in this node should then be "dc" as well.
> 
> The dc driver gets the clock by name, so this isn't a requirement.

Right, but like I've said in another reply, I'd very much like for this
to be fixed up so we don't have to mess around with per-instance names
for clocks. So instead of naming the first clock in the display
controller node "disp", we could rename it to "dc" for consistency with
the reset bindings.

> >> diff --git
> >> a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> >> b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> >
> >> 
> [...]
> >> -  - spdif_in +  - spdif
> > 
> > Why is this renamed?
> 
> There are two separate clocks for the SPDIF input and output modules,
> but just a single reset.

I also realized that when reviewing one of the subsequent patches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/cba4445a/attachment.sig>
