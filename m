From: deller@gmx.de (Helge Deller)
Date: Wed, 22 May 2013 20:19:37 +0200
Subject: [PATCH v2 0/4] dma-mapping: Define dma_{alloc,free}_attrs() for
 all archs
In-Reply-To: <519C2F5D.8000809@igel.co.jp>
References: <1367290899-10410-1-git-send-email-dhobsong@igel.co.jp>
 <519C2F5D.8000809@igel.co.jp>
Message-ID: <519D0C39.6090201@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 04:37 AM, Damian Hobson-Garcia wrote:
> Hello,
> On 2013/04/30 12:01, Damian Hobson-Garcia wrote:
>> Most architectures that define CONFIG_HAVE_DMA=y, have implementations for
>> both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
>> not define CONFIG_HAVE_DMA also have both of these definitions provided by
>> dma-mapping-broken.h.
>>
>> Provide a default definition for the archs that define CONFIG_HAVE_DMA=y,
>> but have no implementation for dma_{alloc,free}_attrs(). 
>>
>> As I don't have hardware for any of these systems, the patches are only
>> compile-tested where I could (arm64, s390) and untested for the archs
>> where I couldn't find a readily available prebuilt cross-compiler (c6x, parisc).
>>
> 
> 
>>  arch/arm64/include/asm/dma-mapping.h  |   17 +++++++++++------
>>  arch/c6x/include/asm/dma-mapping.h    |    3 +++
>>  arch/parisc/include/asm/dma-mapping.h |    3 +++
>>  arch/s390/include/asm/dma-mapping.h   |   17 +++++++++++------
>>  4 files changed, 28 insertions(+), 12 deletions(-)
>>
> 
> Since this series spans several architectures, what would be the best
> way to have this patch series merged?
> Should I resubmit each patch to the mailing list for each architecture
> separately?

I already pushed the parisc change upstream.
See commit 7f64fb41aad9a8504dd76e81b2391eae64e1498a

Helge
