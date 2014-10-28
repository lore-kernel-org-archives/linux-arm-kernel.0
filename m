From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 28 Oct 2014 13:40:49 +0000
Subject: [PATCHv4 7/7] arm64: add better page protections to arm64
In-Reply-To: <CAKv+Gu9GiN8GF2wK=2Z2b15e+NYfQov7rNT2cjmDpRqjMwx1yg@mail.gmail.com>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-8-git-send-email-lauraa@codeaurora.org>
 <20141028112949.GA7978@linaro.org>
 <CAKv+Gu9GiN8GF2wK=2Z2b15e+NYfQov7rNT2cjmDpRqjMwx1yg@mail.gmail.com>
Message-ID: <CAPvkgC1KOjCBWeO5PgU7EznBzh3EnvC1X+sv4MM9x=K5D2DVOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2014 11:44, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 28 October 2014 12:29, Steve Capper <steve.capper@linaro.org> wrote:
>> On Mon, Oct 27, 2014 at 01:12:32PM -0700, Laura Abbott wrote:

[...]

>>
>> I think we should wipe out map_io from all these functions as it's
>> causing too much complexity. It's enough to have just sect_prot and
>> pte_prot. I posted some similar feedback to Ard:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296918.html
>>
>
> I do agree. But could we have a single enum that maps onto {sect_prot,
> pte_prot} tuples rather than having to pass both values everywhere we
> call any of these functions?
> I.e., { MMU_PROT_DEFAULT, MMU_PROT_READONLY, MMU_PROT_READWRITE,
> MMU_PROT_READEXEC, MMU_PROT_DEVICE }, with the mapping local to mmu.c?
>

arch/arm has a mem_types array, I'm not sure how applicable that would
be for arm64
One could also be (slightly) filthy and promote a pte_prot into a
sect_prot via manipulation of the lower 2 bits (see for example
pte_mkhuge).

Basically as long as the mapping logic doesn't make decisions about
which pgprots to use, then I'm happy :-).

Cheers,
--
Steve
