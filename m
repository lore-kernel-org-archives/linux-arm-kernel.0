From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Aug 2015 00:12:59 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: Turn on gmac on Colombus
In-Reply-To: <55D5725F.6000106@redhat.com>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
 <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
 <20150819151754.GH30520@lukather> <55D5725F.6000106@redhat.com>
Message-ID: <20150820221259.GM30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 08:23:27AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/19/2015 05:17 PM, Maxime Ripard wrote:
> >On Fri, Aug 07, 2015 at 05:22:34PM +0200, Hans de Goede wrote:
> >>We've everything we need to support the gmac on Colombus, turn it on.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >I recall that the phy was powered by one of the AXP221 regulators,
> >does it require some additional stuff (like a recent u-boot), or does
> >it just work and my memory is bad :) ?
> 
> I think it just works, it MAY be connected to aldo1 but according to
> the git history for the u-boot defconfig that one is used for wifi not
> for the gmac, and we do not enable any other "spare" regulators in the
> u-boot config.
> 
> I do not have any schematics, so no way to say for sure.
> 
> I can confirm that the GMAC work fine with the latest u-boot
> master. Looking in the history we've always enabled ALDO1
> on the Colombus in upstream u-boot, so this should all just work.

Except that if it is the case, the DT was working fine with the stock
bootloader, and it doesn't anymore, while we have no way to upgrade
it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150821/844b98f9/attachment.sig>
