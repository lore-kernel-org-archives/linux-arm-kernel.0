From: per.forlin@linaro.org (Per Forlin)
Date: Fri, 17 Jun 2011 20:09:44 +0200
Subject: [PATCH v3 RESEND] dma-mapping: add new API for max_segment_number
In-Reply-To: <20110617124035.GA19693@parisc-linux.org>
References: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
	<1308227453-2034-1-git-send-email-shawn.guo@linaro.org>
	<20110617124035.GA19693@parisc-linux.org>
Message-ID: <BANLkTimeS227gz5Bb1f1cN812gOQ5fFnQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2011 14:40, Matthew Wilcox <matthew@wil.cx> wrote:
> On Thu, Jun 16, 2011 at 08:30:53PM +0800, Shawn Guo wrote:
>> Here is the user story that tells the need of the new api. ?The
>> mxs-mmc is the mmc host controller for Freescale MXS architecture.
>> There are a pair of ?mmc host specific parameters max_seg_size and
>> max_segs that mxs-mmc host driver needs to tell mmc core, so that
>> mmc core can know how big each data segment could be and how many
>> segments could be handled one time in a scatter list by host driver.
>>
>> The mxs-mmc driver is one user of dmaengine mxs-dma, and it will call
>> mxs-dma to transfer data in scatter list. ?That is to say mxs-mmc has
>> no idea of what max_seg_size and max_segs should be, because they are
>> all mxs-dma capability parameters, and mxs-mmc needs to query them
>> from mxs-dma.
>
> This approach would make sense if mxs-mmc were generic, but it's tied to
> mxs-dma, so it can just as well call mxs-dma to find out how many segments
> it supports.
>
mxs-dma use the generic dmaengine.h. The patch is not only intended
for mxs-mmc. MMCI and other mmc host drivers need a way to query
max_seg_number.
It would be possible to store this number within drivers/dmaengine but
this would not work for omap_hsmmc that doesn't use drivers/dmaengine

Regards,
Per
