From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 May 2014 16:32:11 +0200
Subject: [PATCH 2/2] ARM: tegra: initial add of Colibri T30
In-Reply-To: <537319CE.7020101@ziswiler.com>
References: <cover.1400001937.git.stefan@agner.ch>
 <d45ec5351ce8ef03256061bdc4b0ba673bd40c66.1400001937.git.stefan@agner.ch>
 <53727738.4080901@wwwdotorg.org> <537319CE.7020101@ziswiler.com>
Message-ID: <20140514143209.GB8612@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 09:22:54AM +0200, Marcel Ziswiler wrote:
> On 05/13/2014 09:49 PM, Stephen Warren wrote:
> >On 05/13/2014 11:27 AM, stefan at agner.ch wrote:
[...]
> >>+	panel: panel {
> >>+		compatible = "edt,et057090dhu", "simple-panel";
> >
> >The panel-simple driver doesn't seem to know about that EDT panel. How
> >will it work out the display timings?
> 
> Good question and me and Stefan actually even talked about that yesterday. I
> am actually using KMS right now as follows:
> 
> video=HDMI-A-1:1280x720-16 at 60 video=LVDS-1:640x480-16 at 60'
> 
> So the panel node is purely used to hook up the back light part right now.
> 
> From our point of view for our completely generic module approach where each
> customer potentially hooks up his own display make/model it would be
> desirable to have some way of defining such timings directly through the
> device tree.

Every customer design would presumably get its own device tree file, so
they could easily follow the current conventions and update the
panel-simple driver with the proper compatible value and display timings
and then simply make the panel device node compatible with that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/8441c07f/attachment-0001.sig>
