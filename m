From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 28 Jun 2017 09:33:33 +0200
Subject: [PATCH v6 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <20170627173640.GA375@lst.de>
References: <1498468741-12020-1-git-send-email-vladimir.murzin@arm.com>
 <20170627152753.GA29186@lst.de> <20170627165416.GP4902@n2100.armlinux.org.uk>
 <20170627173640.GA375@lst.de>
Message-ID: <CA+M3ks6zBzh6oZ-LoVoFEu81vEeH_q=bhWnGrYAgDSpB+kfxyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-27 19:36 GMT+02:00 Christoph Hellwig <hch@lst.de>:
> On Tue, Jun 27, 2017 at 05:54:17PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Jun 27, 2017 at 05:27:53PM +0200, Christoph Hellwig wrote:
>> > I've applied patches 1, 3 and 4 to the dma-mapping tree.  2 will need
>> > a respin for less code duplication.  I'd be happy to take 5,6 and 7 if
>> > Russell is fine with that.
>>
>> If Vladimir is okay with those going in without patch 2, then I'm
>> happy - I seem to remember a mail from Vladimir stating that they
>> depended on some of the previous patches, but I don't know which.
>>
>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Thanks, I'll add them.  Patch 2 only adds optional mmap functionality,
> so it's not really required.  Although I'd really like to see a fixed
> up version that I can merge anyway.

Without mmap we will have a regression for nommu platform which are using
dma_alloc_coherent and specialy in drm/kms where dumb buffer are allocated
like that.
Even with this problem I think the patches should be merged but we should have
a quick fix for mmap.

Benjamin
