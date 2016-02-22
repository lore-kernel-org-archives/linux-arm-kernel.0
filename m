From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 17:56:40 +0100
Subject: [PATCH v3 1/4] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <20160222164958.GJ31168@arm.com>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455289046-21321-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160222164958.GJ31168@arm.com>
Message-ID: <CAKv+Gu_OGJG0i9T=ecFVQM-P8KRpasJ+h6L4onJgpaED07Q8Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 17:49, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 12, 2016 at 03:57:23PM +0100, Ard Biesheuvel wrote:
>> Since architectures may not yet have their linear mapping up and running
>> when the initrd address is discovered from the DT, factor out the
>> assignment of initrd_start and initrd_end, so that an architecture can
>> override it and use the translation it needs.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/of/fdt.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> Mark, Rob, any comments on this?
>

Already acked by Rob, and pulled into -next by Catalin ...
