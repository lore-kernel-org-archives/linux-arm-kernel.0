From: lho@apm.com (Loc Ho)
Date: Fri, 29 May 2015 13:18:47 -0700
Subject: [PATCH v11 0/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20150529185926.GP31435@pd.tnic>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150529094654.GD31435@pd.tnic>
 <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
 <20150529185926.GP31435@pd.tnic>
Message-ID: <CAPw-ZTniFrC6o6eDCLjj7Gk_-C1=u+sPPdzucMX7D2DkwmEuAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 29, 2015 at 11:59 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, May 29, 2015 at 11:06:35AM -0700, Loc Ho wrote:
>> I pull this and got this error:
>>
>> /projects/svdc/P4sbSW/lho/xgene2/processor/git.lho/edac-next/drivers/edac/edac_stub.c:19:22:
>> fatal error: asm/edac.h: No such file or directory
>>  #include <asm/edac.h>
>>                       ^
>> compilation terminated.
>
> Aah, that arch-specific header is only for the atomic_scrub thing and
> arm64 doesn't have it.
>
> But that header is actually not really needed in that file.
>
> Does it build when you remove it?

It should because all I did to fix it was an touch on
"arch/arm64/include/asm/edac.h".

-Loc
