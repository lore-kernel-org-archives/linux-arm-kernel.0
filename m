From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Mon,  3 Aug 2015 11:03:52 +0200 (CEST)
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
 <CAGb2v67o-=_cL2RWfXJ+3C86zfQ_1b5DYRi3_zwvwy6su6+gdw@mail.gmail.com><CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
Message-ID: <20150803090352.621CC6C80865@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Julian Calaby schrieb am 03.08.2015 06:22:
> My only real objection here is are there boards that can go down to
> 0.9v and if so, won't this change make them less power efficient in
> the almost-idle case? And are those power savings enough to justify
> not accepting this patch?

It will probably make those boards less power efficient, yes. On the
other hand, boards that have their CPU regulator set to min. 1.0V might
also draw more power because the lowest frequency is not available, 
even though the savings due to frequency are likely to be lower than
the savings due to voltage.

However, Stefan Monnier (added to CC) mentioned in an earlier
discussion that the savings for the lowest opp are rather small and
thus the benefit of the 144MHz opp would be questionable.

Unfortunately, I don't have measurement equipment precise enough to
test this myself and haven't found a way to read power consumption
internally via the PMU in mainline yet.

Thanks,

Timo
