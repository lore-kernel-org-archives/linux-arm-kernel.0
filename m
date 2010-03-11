From: svenkatr@ti.com (Venkatraman S)
Date: Thu, 11 Mar 2010 16:22:19 +0530
Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
In-Reply-To: <011301cac0b6$542b1190$544ff780@am.dhcp.ti.com>
References: <618f0c911003010327s290fcce1ud665b5a16392aea1@mail.gmail.com>
	<011301cac0b6$542b1190$544ff780@am.dhcp.ti.com>
Message-ID: <618f0c911003110252i36d6fc31wbaef4ad7a17565b1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Madhusudhan <madhu.cr@ti.com> wrote:
>> -----Original Message-----
>> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
>> owner at vger.kernel.org] On Behalf Of Venkatraman S
>> Sent: Monday, March 01, 2010 5:27 AM
>> To: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-omap at vger.kernel.org
>> Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
>> autoloading feature
>>
>> Start to use the sDMA descriptor autoloading feature.
>> For large datablocks, the MMC driver has to repeatedly setup, program
>> and teardown the
>> dma channel for each element of the sglist received in omap_hsmmc_request.
>>
>> By using descriptor autoloading, transfers from / to each element of
>> the sglist is pre programmed
>> into a linked list. The sDMA driver completes the entire transaction
>> and provides a single interrupt.
>>
>> Due to this, number of dma interrupts for a typical 100MB transfer on the
>> MMC is
>> reduced from 25000 to about 400 (approximate). Transfer speeds are
>> improved by ~5%
>> (Though it varies on the size of read / write & improves on huge
>> transfers)
>>
>> Descriptor autoloading is available only in 3630 and 4430 (as of now).
>> Hence normal DMA
>> mode is also retained.
>>
>> Tested on omap4430 sdp.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
> I don't see any issues with this patch except the concern I had on the first
> patch in the series. Why is that change linked to this series?
>
  Thanks. The problem was seen only in the context of using descriptor
load. Would
you prefer that I post it as a separate patch ?
Regards,
Venkat.
