From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Wed, 31 Jul 2013 17:49:53 +0200
Subject: [PATCH 4/4] ARM: sun6i: Enable clock support in the DTSI
In-Reply-To: <2013073120102496855035@gmail.com>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-5-git-send-email-maxime.ripard@free-electrons.com>
 <51F86A2E.10505@elopez.com.ar> <20130731073724.GA24439@lukather>
 <2013073116110750016327@gmail.com> <20130731114957.GD2911@lukather>
 <2013073120102496855035@gmail.com>
Message-ID: <20130731154953.GG2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, Jul 31, 2013 at 08:10:32PM +0800, kevin.z.m wrote:
> > How does one select either the internal or the external 32kHz
> > oscillator? Is this done in software (I can't find any reference to that
> > in the user manuals) or in hardware?
> For A20, it should be in the Timer module, and there is a register named "LOSC_CTRL_REG".
> For A31, it is in the RTC module, same name of "LOSC_CTRL_REG".

Ok, just so that we're on the same page, we have two oscillators running
at 32kHz, the internal being always there, and the external that could
or could not be there, and it's each different hardware block that can
be wired to one, the other or both?

There's no global mux that could use either one of the two 32k to
provide the only 32kHz source in the system, right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/0bb8be73/attachment.sig>
