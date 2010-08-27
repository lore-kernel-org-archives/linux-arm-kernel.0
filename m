From: konkers@android.com (Erik Gilling)
Date: Fri, 27 Aug 2010 12:26:03 -0700
Subject: [PATCH v2] spi: add spi_tegra driver
In-Reply-To: <AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
	<AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
	<AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge@mail.gmail.com>
Message-ID: <AANLkTin4HxVLt=4VH-NQWhB-p_2EpX_yoTcwEOTJP3m_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 2:22 PM, Erik Gilling <konkers@android.com> wrote:
>> As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
>> pattern in the tegra_dma_allocate_channel() return really a good idea
>> here? ?Personally I find that pattern isn't very useful, especially
>> when the results is either "yes, allocated" or "no, not-alocated", and
>> it is very easy to write code that tests the wrong thing on the return
>> value because the compiler cannot catch it. ?In other words, if it
>> isn't vital to return a specific error code, the using the PTR_ERR()
>> pattern adds unnecessary risk to the code because developers are used
>> to seeing and writing this pattern:
>>
>> tspi->rx_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
>> if (!tspi->rx_dma)
>> ? ? ? ?return -ENOMEM;
>>
>> The compiler won't catch it if the return value is an PTR_ERR.
>>
>> (I know that some subsystems make heavy use of it, particularly
>> filesystems and the block layer which do need to return specific error
>> codes to userspace. ?My argument is that the specific error code is
>> probably irrelevant when allocating DMA channels)
>
> I don't have a strong opinion either way but that's the way Colin's
> code is written. ?I'll let him speak to that.

I spoke with colin about this.  He's fine getting rid of the PTR_ERR.
I'll post a DMA and SPI patch when that's done.

-Erik
