From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:34:20 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <20150803090352.621CC6C80865@dd34104.kasserver.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
 <CAGb2v67o-=_cL2RWfXJ+3C86zfQ_1b5DYRi3_zwvwy6su6+gdw@mail.gmail.com>
 <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
 <20150803090352.621CC6C80865@dd34104.kasserver.com>
Message-ID: <20150803093420.GC2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 11:03:52AM +0200, Timo Sigurdsson wrote:
> Hi again,
> 
> Julian Calaby schrieb am 03.08.2015 06:22:
> > My only real objection here is are there boards that can go down to
> > 0.9v and if so, won't this change make them less power efficient in
> > the almost-idle case? And are those power savings enough to justify
> > not accepting this patch?
> 
> It will probably make those boards less power efficient, yes. On the
> other hand, boards that have their CPU regulator set to min. 1.0V might
> also draw more power because the lowest frequency is not available, 
> even though the savings due to frequency are likely to be lower than
> the savings due to voltage.

Guys, isn't this whole discussion a bit moot? We're not doing any kind
of power management but cpufreq, so maybe there's a lot more to do
before we actually can have these kind of arguments?

Plus this OPP has never been used anyway, so this patch is not going
to increase the power consumption either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/6e4a74ec/attachment.sig>
