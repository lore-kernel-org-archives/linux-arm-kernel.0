From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 31 Mar 2017 14:27:51 +1100
Subject: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
In-Reply-To: <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
 <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
Message-ID: <871ste5dmw.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin Murphy <robin.murphy@arm.com> writes:

> Hi Roy,
>
> On 29/03/17 22:13, Roy Pledge wrote:
>> Use the shared-memory-pool mechanism for frame queue descriptor and
>> packed frame descriptor record area allocations.
>
> Thanks for persevering with this - in my opinion it's now looking like
> it was worth the effort :)
>
> AFAICS the ioremap_wc() that this leads to does appear to give back
> something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
> horrendously misnamed), and "no-map" should rule out any cacheable
> linear map alias existing, so it would seem that this approach should
> avert Scott's concerns about attribute mismatches.

How does 'no-map' translate into something being excluded from the
linear mapping?

cheers
