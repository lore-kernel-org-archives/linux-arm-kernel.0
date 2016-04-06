From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 6 Apr 2016 18:30:11 +0300
Subject: [PATCH v2 5/5] dmaengine: qcom: bam_dma: rename BAM_MAX_DATA_SIZE
 define
In-Reply-To: <20160405234739.GF11586@vkoul-mobl.iind.intel.com>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-6-git-send-email-stanimir.varbanov@linaro.org>
 <20160405234739.GF11586@vkoul-mobl.iind.intel.com>
Message-ID: <57052B83.4000208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2016 02:47 AM, Vinod Koul wrote:
> On Wed, Apr 06, 2016 at 01:56:22AM +0300, Stanimir Varbanov wrote:
>> It seems that the define has not been with acurate name and
>> makes confusion while reading the code. The more acurate
>> name should be BAM_FIFO_SIZE.
> 
> And not sure by that, what do you mean by FIFO size. In dmaengine context we

By BAM_FIFO_SIZE I meant a FIFO depth for hw descriptors, i.e. how many
hw descriptors could be pushed into the descriptor FIFO. In our case we
wrote BAM_P_FIFO_SIZES register with SZ_32K - 8, which means that the
FIFO will be 4095 hw descriptors deep.

In fact the important patch in this series 4/5 where I corrected the
value we wrote in BAM_P_FIFO_SIZES register.

4/5 and 5/5 can be postponed till we have better decision...

-- 
regards,
Stan
