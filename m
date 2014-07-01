From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 1 Jul 2014 17:22:21 +0100
Subject: [PATCH v2 4/5] efi: efistub: refactor stub components
In-Reply-To: <CAKv+Gu8sHpHNEJhDrrJcN12rVrhRgprzmNeJ_BoMCbL+Gh2-NQ@mail.gmail.com>
References: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
 <1403792617-25792-5-git-send-email-ard.biesheuvel@linaro.org>
 <20140701151130.GF7539@console-pimps.org>
 <CAKv+Gu9tY7RqVXdWejwOPnpBTX0S5M9QxBH2te71kpysOV3vWA@mail.gmail.com>
 <CAKv+Gu8sHpHNEJhDrrJcN12rVrhRgprzmNeJ_BoMCbL+Gh2-NQ@mail.gmail.com>
Message-ID: <20140701162221.GG7539@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Jul, at 05:20:21PM, Ard Biesheuvel wrote:
> 
> ... but that wasn't your question ....
> 
> The reason this can't live in "efistub.h" is that it gets included by
> bits under arch/xxx
> So perhaps moving the local "efistub.h" to <linux/efistub.h> would be
> appropriate, yes.

I didn't mean that we should add include/linux/efistub.h, rather that we
should try adding them to efistub.h or asm/efi.h.

But I see that isn't going to work too well and there's no easy fix.
Let's just leave things as they are for now.

Long term, I've been thinking of splitting up include/linux/efi.h. It's
currently weighing in at 1208 lines and contains pieces for all sorts of
different chunks of EFI code, 32-bit and 64-bit versions of data
structures, etc.

-- 
Matt Fleming, Intel Open Source Technology Center
