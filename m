From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 11:39:45 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <561F75D2.8010301@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <20151014172418.GI5041@leverpostej> <561F75D2.8010301@arm.com>
Message-ID: <20151015103945.GD8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
> >>+#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
> >>+
> >>+#else
> >>+
> >>+#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
> >>+#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON
> >
> >Any reason for not using upper-case names for the macros?
> 
> Nothing in particular. I had them in upper-case in the previous version,
> changed it here ;) for absolutely no reason. I could switch it back.

Please do!

> >Given they're local you could just call them TGRAN_SHIFT and TRGRAN_ON
> >to make the asm slightly nicer.
> 
> Given Jeremy's suggestion to add something to the EFI stub, I will retain
> the original definition with all upper-case and define it somewhere in
> a header so that we can reuse it.

Ok, that's also fine by me.

Thanks,
Mark.
