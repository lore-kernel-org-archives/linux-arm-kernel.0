From: bp@alien8.de (Borislav Petkov)
Date: Wed, 6 May 2015 10:41:43 +0200
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <1430884947-16787-1-git-send-email-lho@apm.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
Message-ID: <20150506084143.GA22949@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 10:02:22PM -0600, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC memory controller EDAC driver
> for DT.
> 
> v8:
> * Change ASM_EDAC_H to __ASM_EDAC_H in file edac.h
> * Add WARN_ONCE in stub function atomic_scrub
> * Update DTS binding documentation (with only memory controller node)
> * Temporary remove L1/L2, L3, and SoC driver code and update memory driver
>   code accordingly

What does that mean exactly? They'll get added later?

It is called now xgene_edac_mc.c. Am I to expect more
xgene_edac_<functional_unit>.c submissions? What happened to building
everything around the shared IRQ handler?

Also, I see this SOB chain in some of the patches:

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>

and it is not clear who did what, from looking at the chain.

If you both authored the patches, you can write

Originally-by: Feng
[ Loc: did this and that]
Signed-off-by: Loc

for example.

See Documentation/SubmittingPatches for more info.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
