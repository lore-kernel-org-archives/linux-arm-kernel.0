From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Jun 2014 16:22:44 +0200
Subject: [PATCH v2 0/2] efi: preserve NEON registers on UEFI services calls
In-Reply-To: <1403791087.755.120.camel@deneb.redhat.com>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
 <1403791087.755.120.camel@deneb.redhat.com>
Message-ID: <CAKv+Gu-1qbn=VagWKkwkr2aJg3k6UcWEqa8EQKGocuaLxb9+Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2014 15:58, Mark Salter <msalter@redhat.com> wrote:
> On Thu, 2014-06-26 at 12:09 +0200, Ard Biesheuvel wrote:
>> The current UEFI implementation for arm64 fails to preserve/restore the contents
>> of the NEON register file,
>
> Does the current implementation actually use NEON registers?
> I know there are some at least, which build with -mgeneral-regs-only
> to keep gcc from using NEON registers.
>

Tianocore/EDK2 does not use -mgeneral-regs-only when building for
AArch64, and my current build shows that, for instance, GCC starts
spilling to FP registers when compiling the LZMA decoder, and it is
likely to do the same for the crypto bits once I start enabling them
(although, interestingly enough, the OpenSSL SHA-1 C implementation
runs 60% faster with -mgeneral-regs-only set)

> Not that that means we don't need this. Just curious.
>

The spec does not forbid it, so we will need it anyhow ...

-- 
Ard.
