From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 22 Apr 2011 09:34:00 +0900
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <BANLkTim5umALqafjA2e88UCLzMp9LQu3_Q@mail.gmail.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110421130930.4be9e9e1@jbarnes-desktop>
	<BANLkTim5umALqafjA2e88UCLzMp9LQu3_Q@mail.gmail.com>
Message-ID: <BANLkTimz8zprEw7H_i8g2qj8RyyougiBBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 6:52 AM, Zach Pfeffer <zach.pfeffer@linaro.org> wrote:
>
> I agree with Jesse that the separation of mapping from allocation is
> central to the current usage models. I realize most people didn't like
> VCMM, but it provided an abstraction for this - if software can handle
> the multiple mapper approach in a rational way across ARM than we can
> solve a lot of problems with all the map and unmap current solutions
> and we don't have to hack in coherency.
>

Hi.
I've also noticed that VCMM is the reasonable idea for IOMMU mappings.
We often deal with physical memory blocks to map multiple way.
Allocation of physical memory itself is also important for some
peripheral devices
because it is beneficial to get larger page frame for their performance.

IOMMU api does not provide virtual memory management.
DMA api is not flexible for all our use-cases.

Regards,
KyongHo.
