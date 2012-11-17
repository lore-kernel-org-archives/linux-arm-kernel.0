From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 17 Nov 2012 08:30:22 +0100
Subject: [PATCH] ARM: tegra: seaboard: enable internal LCD
In-Reply-To: <50A7020B.6070708@nvidia.com>
References: <1353092114-18410-1-git-send-email-swarren@wwwdotorg.org>
 <50A7020B.6070708@nvidia.com>
Message-ID: <20121117073022.GB26391@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 12:18:35PM +0900, Alex Courbot wrote:
> On 11/17/2012 03:55 AM, Stephen Warren wrote:
> >+	host1x {
> >+		dc at 54200000 {
> >+			rgb {
> >+				status = "okay";
> >+				nvidia,ddc-i2c-bus = <&lcd_ddc>;
> >+				backlight = <&backlight>;
> 
> I guess the remark Thierry made on my patch that the property should
> be "nvidia,backlight" (and that it will not be supported for 3.8
> anyway) also applies here.

Yes, and the property should go into the rgb's display subnode.
Eventually this will need to be hooked up to the panel framework once
that's ready.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121117/4d19fdbd/attachment.sig>
