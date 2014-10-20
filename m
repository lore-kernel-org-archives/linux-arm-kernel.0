From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 20 Oct 2014 12:07:38 +0100
Subject: arm64 build failures in -next
In-Reply-To: <20141020105210.GP18557@sirena.org.uk>
References: <E1Xg5Gy-00082k-6v@debutante>
 <20141020105210.GP18557@sirena.org.uk>
Message-ID: <CAPvkgC07KrZyx+--eUNb2OLz1wSCa-Gu4r3FkLoRFf4QjMFYrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 October 2014 11:52, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 20, 2014 at 06:12:48AM +0100, Build bot for Mark Brown wrote:
>
> For the past few days arm64 has been failing to build in -next due to:
>
>>       arm64-allmodconfig
>> ../mm/gup.c:963:3: error: implicit declaration of function 'pgd_huge' [-Werror=implicit-function-declaration]
>>
>>       arm64-defconfig
>> ../mm/gup.c:963:3: error: implicit declaration of function 'pgd_huge' [-Werror=implicit-function-declaration]
>
> which appears to be due to "mm/gup.c: update generic gup implementation
> to handle hugepage directory".  That patch added a default definition of
> pgd_huge() in the !CONFIG_HUGETLB_PAGE case but only PowerPC provides an
> actual definition of that function.

The patch responsible for this has been removed from -mm (because of
this issue), I think it will leave -next too?

Cheers,
--
Steve
