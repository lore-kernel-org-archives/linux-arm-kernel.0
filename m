From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Wed, 21 Sep 2016 14:10:55 +0000
Subject: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
In-Reply-To: <20160920191744.GA4941@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com>
 <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F87CF8F@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn

[...]


> 
> If future hardware is completely ECAM-compliant and we don't need any
> more MCFG quirks, that would be great.
> 
> But we'll still need to describe that memory-mapped config space
> somewhere.  If that's done with PNP0C02 or similar devices (as is done
> on my x86 laptop), we'd be all set.
> 
> If we need to work around firmware in the field that doesn't do that,
> one possibility is a PNP quirk along the lines of
> quirk_amd_mmconfig_area().

So, if my understanding is correct, for platforms that have not been
shipped yet you propose to use PNP0C02 in the ACPI table in order to
declare a motherboard reserved resource whereas for shipped platforms
you propose to have a quirk along pnp_fixups in order to track the
resource usage even if values are hardcoded...correct?

Before Tomasz came up with this patchset we had a call between the vendors
involved in this PCI quirks saga and other guys from Linaro and ARM.

Lorenzo summarized the outcome as in the following link
http://lkml.iu.edu/hypermail/linux/kernel/1606.2/03344.html

Since this quirks mechanism has been discussed for quite a long time now
IMHO it would be good to have a last call including also you (Bjorn) so
that we can all agree on what to do and we avoid changing our drivers again
and again...

What do you think?

Thanks

Gab

> 
> Bjorn
