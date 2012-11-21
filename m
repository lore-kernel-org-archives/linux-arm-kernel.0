From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Nov 2012 11:15:23 +0100
Subject: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <87mwycjmdn.fsf@dell.be.48ers.dk>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-5-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
 <5097B7EE.3000508@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
 <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk>
Message-ID: <50ACA9BB.7090106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2012 16:59, Peter Korsgaard wrote:
>>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:
> 
> Hi,
> 
>  >>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
>  >>>> OMAP_ECC_HAMMING_CODE_HW_ROMCODE
>  >>>> OMAP_ECC_BCH4_CODE_HW
>  >>>> OMAP_ECC_BCH8_CODE_HW
>  >>>> 
>  >>>> So selection of ecc layout data should come from DT not ecc mode.
>  >>> 
>  >>> Ok, I see. I would still like to set them by string rather than magic
>  >>> numbers that map to enum entries. Valid values would be "none", "hw",
>  >>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
>  >> 
>  >> Ok, that's nice. Better use ecc_opt instead of ecc_mode.
> 
>  Daniel> I did some more extensive tests that include reading the same
>  Daniel> nand pages from both U-Boot and the kernel with BCH8 ECC, and
>  Daniel> it turns out that -> is_elm_used needs to be set in the pdata
>  Daniel> in order to make this work.
> 
> So what you're saying is that the choice of ELM or not is not just an
> optimization, it really changes the ECC layout? Perhaps it should be
> treated as a seperate layout (E.G. bch8-elm) then?

That is what I experienced, yes. The kernel was unable to parse NAND
pages that were written from U-Boot with bch8 hardware mode when the elm
module was not active. Maybe someone from TI can explain that? Giving it
a dedicated name would also solve the problem with the extra DT property.

I'll wait until this is decided before I resend a new set that also
fixes the issue with the errornousely forgotten Documentation file.


Thanks,
Daniel
