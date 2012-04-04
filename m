From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 4 Apr 2012 20:11:21 +0200
Subject: [PATCH v5 15/16] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <4F7603BC.2050300@wwwdotorg.org>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-16-git-send-email-thierry.reding@avionic-design.de>
 <4F7603BC.2050300@wwwdotorg.org>
Message-ID: <20120404181121.GA19755@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/28/2012 08:33 AM, Thierry Reding wrote:
> > This commit adds very basic support for device tree probing. Currently,
> > only a PWM and a list of distinct brightness levels can be specified.
> > Enabling or disabling backlight power via GPIOs is not yet supported.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> > diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
> > +Required properties:
> > +  - compatible: "pwm-backlight"
> > +  - pwms: OF device-tree PWM specification (see PWM binding[0])
> > +  - num-brightness-levels: number of distinct brightness levels
> 
> Do we need the "num-brightness-levels" property at all; it's just the
> length of the brightness-levels property.

No, we don't really need it. As you say, it can be derived from the property
length.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/6c150550/attachment-0001.sig>
