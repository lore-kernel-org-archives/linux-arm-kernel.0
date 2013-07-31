From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Wed, 31 Jul 2013 13:49:57 +0200
Subject: [PATCH 4/4] ARM: sun6i: Enable clock support in the DTSI
In-Reply-To: <2013073116110750016327@gmail.com>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-5-git-send-email-maxime.ripard@free-electrons.com>
 <51F86A2E.10505@elopez.com.ar> <20130731073724.GA24439@lukather>
 <2013073116110750016327@gmail.com>
Message-ID: <20130731114957.GD2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Jul 31, 2013 at 04:11:11PM +0800, kevin.z.m wrote:
> Hi, Maxime,
> 
> > The problem is a bit more complex than that.
> 
> > On the A31, the losc clock is actually a mux between an external
> > oscillator running at 32kHz, and the internal oscillator running at
> > 667MHz, that would be scaled down.
> 
> > Support for this mux is not quite there yet, since I've not seen any
> > documentation for it, but this would allow to just rearrange losc
> > parents and compatible when we will had such support.
> 
> I think there is some misunderstanding. All allwinner's platforms have 
> 2 losc clock source. One is the external 32KHz oscillator, and the other
> is internal 32kHz R/C circuit. The internal 32k R/C circuit can't provide
> a very exact clock on 32KHz. The mux is just for select external osc or internal
> 32KHz R/C. If there is no external 32kHz oscillator, we can replace it with 
> internal 32kHz R/C for some low speed but not exact clock requirement.

Thanks for the clarification.

How does one select either the internal or the external 32kHz
oscillator? Is this done in software (I can't find any reference to that
in the user manuals) or in hardware?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/aacb1f76/attachment.sig>
