From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Dec 2014 13:10:11 +0100
Subject: arm64 broken in -next by commit 08d53aa58cb1 (of/fdt: export fdt
 blob as /sys/firmware/fdt)
In-Reply-To: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
References: <20141210120422.GB13994@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-5evt=quj8n8UEtR6wKQhYt4crrFRz2pvjhD1267SCrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2014 at 13:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Ard,
>
> I noticed that linux-next no longer boots on Juno. Bisecting, I ended up
> on your commit above and reverting it gets things going again. I

That's odd.

> initially thought it has something to do with the hardware crypto since
> you added some crc32_be() calls but disabling arm64 hw crypto didn't
> make any difference.
>

No, this patch adds direct crc32() calls into lib/crc32.c that are not
routed through the crypto layer, so your finding here matches my
expectation.

> Still investigating but I thought I should let you know early.
>

Thanks.

Could you elaborate on the symptoms?

-- 
Ard.
