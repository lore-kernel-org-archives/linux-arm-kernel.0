From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Aug 2015 08:23:27 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: Turn on gmac on Colombus
In-Reply-To: <20150819151754.GH30520@lukather>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
 <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
 <20150819151754.GH30520@lukather>
Message-ID: <55D5725F.6000106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/19/2015 05:17 PM, Maxime Ripard wrote:
> On Fri, Aug 07, 2015 at 05:22:34PM +0200, Hans de Goede wrote:
>> We've everything we need to support the gmac on Colombus, turn it on.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> I recall that the phy was powered by one of the AXP221 regulators,
> does it require some additional stuff (like a recent u-boot), or does
> it just work and my memory is bad :) ?

I think it just works, it MAY be connected to aldo1 but according to
the git history for the u-boot defconfig that one is used for wifi not
for the gmac, and we do not enable any other "spare" regulators in the
u-boot config.

I do not have any schematics, so no way to say for sure.

I can confirm that the GMAC work fine with the latest u-boot
master. Looking in the history we've always enabled ALDO1
on the Colombus in upstream u-boot, so this should all just work.

Regards,

Hans
