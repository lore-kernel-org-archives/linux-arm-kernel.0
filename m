From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 10 Aug 2016 19:01:05 +0800
Subject: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <20160810104513.GB16664@nazgul.tnic>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
 <20160810104513.GB16664@nazgul.tnic>
Message-ID: <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 10 August 2016 at 18:45, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Aug 10, 2016 at 06:40:53PM +0800, Fu Wei wrote:
>> But the reason for a  separate hest_ia32_init() is:
>> For now(ACPI 6.1), we have three IA-32 Architecture-specific error
>> source structures, maybe we will parse them later.
>> So I made this hest_ia32_init() for all these structures. maybe we can do :
>
> So I'd make it as simple as possible now and cross that bridge only when
> we get there, i.e., only when you are adding support for those and not
> earlier.
>

OK, got your point.
Sorry for sending v13 before checking this with you.

so I will do :

@@ -232,8 +243,9 @@ void __init acpi_hest_init(void)
  goto err;
  }

- if (!acpi_disable_cmcff)
- apei_hest_parse(hest_parse_cmc, NULL);
+ rc =apei_hest_parse(hest_parse_cmc, NULL);
+ if (rc)
+ goto err;

  if (!ghes_disable) {
  rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);

Do you have other suggestion? then I can post v14 to fix it :-)

> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
>
> SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
> --



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
