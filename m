From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 12 Jul 2011 13:24:48 +0200
Subject: [PATCH v6] mmc: documentation of mmc non-blocking request usage
	and design.
In-Reply-To: <4E1B93CF.60700@linux.intel.com>
References: <1310325719-2151-1-git-send-email-per.forlin@linaro.org>
	<4E1B93CF.60700@linux.intel.com>
Message-ID: <CAJ0pr1_Tru1d4Crp3_sXxrTN+PTGN+hMkMWrLKgNPVJOvdanmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 July 2011 02:22, J Freyensee <james_p_freyensee@linux.intel.com> wrote:
> On 07/10/2011 12:21 PM, Per Forlin wrote:
>> +MMC host extensions
>> +===================
>> +
>> +There are two optional members in the
>> +mmc_host_ops -- pre_req() and post_req() -- that the host
>> +driver may implement in order to move work to before and after the actual
>> +mmc_host_ops.request() function is called. In the DMA case pre_req() may
>> do
>> +dma_map_sg() and prepare the DMA descriptor, and post_req() runs
>> +the dma_unmap_sg().
>> +
>
> One question: Is the 'Optimize for the first request' below an example of
> how to use the 'MMC host extensions' above?
Yes.

> ?So just using 'mmc_start_req()'
> in an MMC client driver would not be beneficial if the MMC host was not also
> using the MMC host extensions, right?
>
Yes. There may be some exceptions where there is gain without any host
driver change. For instance when using dma_bounce, the bounce_copy
would be done in parallel with an active transfer.
Future work on eMMC HPI support (Venkatraman is working on this) can
use the new extensions to interrupt ongoing write to make way for
higher prio read.

> Thanks,
> Jay

You're welcome,
Per
