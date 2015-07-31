From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 09:57:18 +0200
Subject: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
In-Reply-To: <20150731083541.5f2c683a@pluto.restena.lu>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
 <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
 <20150731083541.5f2c683a@pluto.restena.lu>
Message-ID: <20150731075718.GW2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 08:35:41AM +0200, Bruno Pr?mont wrote:
> > > NB: I should hopefully get my battery supply driver ported this WE,
> > > ac-in/rtc are done, this WE. I'm going to default-off for them as well
> > > (note that for some extra details should be provided in dts).
> > 
> > I'm guessing we won't be using the axp288 one?
> 
> In a first step I won't be using it.
> 
> There are a few reasons for that:
> - axp288 is based on ACPI/platform to provide configuration information
>   instead of dts

That's not an issue. You have an API to handle lookup in both DT and
ACPI (the fwnode_* stuff).

> - it makes extensive use of OCV and registers that are possibly present
>   on axp20x but undocumented there.

That will be more problematic. Still I don't see why we wouldn't use a
similar setup to what they did.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/796bb5e1/attachment.sig>
