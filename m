From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 5 Sep 2010 18:50:17 +0800
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100902055907.GA3287@riccoc20.at.omicron.at>
References: <20100819174426O.fujita.tomonori@lab.ntt.co.jp>
	<m3sk1yzkjw.fsf@intrepid.localdomain>
	<20100901085738.GJ8142@n2100.arm.linux.org.uk>
	<20100902114937X.fujita.tomonori@lab.ntt.co.jp>
	<20100902055907.GA3287@riccoc20.at.omicron.at>
Message-ID: <AANLkTi=TfmFPSfw3iYUMzxdsCLC7keJxMbb7vZvQHoiO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 2, 2010 at 1:59 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Thu, Sep 02, 2010 at 11:50:33AM +0900, FUJITA Tomonori wrote:
>> btw, I can't compile ARCH_IXP4XX without the following patch:
>>
>> http://www.spinics.net/lists/arm-kernel/msg95933.html
>
> I have the same problem. Compilation of IXP4xx was broken by
>
> ? ?commit 4fa5518c65df7a2c4b6c58061ac53d0b01228042
> ? ?Author: Eric Miao <eric.y.miao@gmail.com>
> ? ?Date: ? Sat Jun 5 15:16:17 2010 +0800
>
> ? ?[ARM] pxa: remove now unnecessary dma_needs_bounce()
>
> What is the correct way to do fix this? Is the above patch the
> solution, or is dma_needs_bounce() perhaps also unnecessary for ixp?
>

My bad to break this. If there is no quick proper fix, I'd prefer this
being reverted first.
