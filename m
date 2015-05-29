From: bp@alien8.de (Borislav Petkov)
Date: Fri, 29 May 2015 20:59:26 +0200
Subject: [PATCH v11 0/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150529094654.GD31435@pd.tnic>
 <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
Message-ID: <20150529185926.GP31435@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 11:06:35AM -0700, Loc Ho wrote:
> I pull this and got this error:
> 
> /projects/svdc/P4sbSW/lho/xgene2/processor/git.lho/edac-next/drivers/edac/edac_stub.c:19:22:
> fatal error: asm/edac.h: No such file or directory
>  #include <asm/edac.h>
>                       ^
> compilation terminated.

Aah, that arch-specific header is only for the atomic_scrub thing and
arm64 doesn't have it.

But that header is actually not really needed in that file.

Does it build when you remove it?

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
