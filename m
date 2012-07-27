From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 27 Jul 2012 10:51:58 +0800
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <1343297355.1726.8982.camel@vkoul-udesk3>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
 <1343285475.1726.8981.camel@vkoul-udesk3>
 <CAMj5BkhpcV=J8goZXMHt2o6bGgn9KL+-mseALN8L2FOpgr2MgA@mail.gmail.com>
 <1343297355.1726.8982.camel@vkoul-udesk3>
Message-ID: <CAMj5BkjEO4Opkx1GxjzX7ZBzRRQLVDKRnK2YA2PuMJ8V9vRD+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 6:09 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-07-26 at 15:02 +0800, zhangfei gao wrote:
>> On Thu, Jul 26, 2012 at 2:51 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
>> > On Fri, 2012-07-20 at 13:46 +0800, Zhangfei Gao wrote:
>> >> +struct mmp_dma_platdata {
>> >> +       int chancnt;
>> >> +};
>> >> +
>> >> +struct mmp_dma_slave_config {
>> >> +       struct dma_slave_config slave_config;
>> >> +       u32 drcmr;
>> >> +};
>> > Why do you need these definitions?
>> >
>> > What is drcmr used for?
>>
>> Hi, Vinod
>>
>> "drcmr" is request_line, we used to select which channel map to
>> specific peripheral.
>> Is it possible adding request_line to slave_config?
> Can you use the slave_id.
>

Good suggestion

If passing drcmr does not break original design of slave_id,
mmp-pdma just need one config member.
While some device (nand) use memcpy method instead of slave_sg.

 * @slave_id: Slave requester id. Only valid for slave channels. The dma
 * slave peripheral will have unique id as dma requester which need to be
 * pass as slave config.

Will update with slave_id in v1 version.

Thanks Vinod.
