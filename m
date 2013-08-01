From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Thu, 1 Aug 2013 11:53:13 +0200
Subject: [PATCH 4/4] ARM: sun6i: Enable clock support in the DTSI
In-Reply-To: <2013080108343040654547@gmail.com>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-5-git-send-email-maxime.ripard@free-electrons.com>
 <51F86A2E.10505@elopez.com.ar> <20130731073724.GA24439@lukather>
 <2013073116110750016327@gmail.com> <20130731114957.GD2911@lukather>
 <2013073120102496855035@gmail.com> <20130731154953.GG2911@lukather>
 <2013080108343040654547@gmail.com>
Message-ID: <20130801095313.GK2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Aug 01, 2013 at 08:34:35AM +0800, kevin.z.m wrote:
> > Ok, just so that we're on the same page, we have two oscillators running
> > at 32kHz, the internal being always there, and the external that could
> > or could not be there, and it's each different hardware block that can
> > be wired to one, the other or both?
> The selection of internal or external is a global setting for system.
> Hardware blocks ?such as cpu?twi for ex.) just see a 32kHz clock
> source, but they don't care where the 32kHz clock
> from.

Ok.

> > There's no global mux that could use either one of the two 32k to
> > provide the only 32kHz source in the system, right?
> There is a global mux to select internal or external, but no mux for
> every hardware blocks. I think that the mux need not be managed in the
> clock driver. It should be set earlier in the boot loader. 
> And the selection is keeping either system is power-on or power-off,
> when there is a power supply with battery or DC. Because the mux is in
> RTC power domain.

Yes, in that case, we mostly don't care for now. Maybe we will at some
point if we need to add power management features, but we'd better
consider a fixed-rate clock for now and not worry too much about it.

Thanks for your help!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130801/a5c85df6/attachment.sig>
