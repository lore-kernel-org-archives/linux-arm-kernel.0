From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 20 Nov 2012 16:59:48 +0100
Subject: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <509EA360.2050504@gmail.com> (Daniel Mack's message of "Sat, 10
 Nov 2012 19:56:32 +0100")
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-5-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
 <5097B7EE.3000508@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
 <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com>
Message-ID: <87mwycjmdn.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 >>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
 >>>> OMAP_ECC_HAMMING_CODE_HW_ROMCODE
 >>>> OMAP_ECC_BCH4_CODE_HW
 >>>> OMAP_ECC_BCH8_CODE_HW
 >>>> 
 >>>> So selection of ecc layout data should come from DT not ecc mode.
 >>> 
 >>> Ok, I see. I would still like to set them by string rather than magic
 >>> numbers that map to enum entries. Valid values would be "none", "hw",
 >>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
 >> 
 >> Ok, that's nice. Better use ecc_opt instead of ecc_mode.

 Daniel> I did some more extensive tests that include reading the same
 Daniel> nand pages from both U-Boot and the kernel with BCH8 ECC, and
 Daniel> it turns out that -> is_elm_used needs to be set in the pdata
 Daniel> in order to make this work.

So what you're saying is that the choice of ELM or not is not just an
optimization, it really changes the ECC layout? Perhaps it should be
treated as a seperate layout (E.G. bch8-elm) then?

-- 
Bye, Peter Korsgaard
