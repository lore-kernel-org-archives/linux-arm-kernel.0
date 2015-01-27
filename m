From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Tue, 27 Jan 2015 12:34:13 +0530
Subject: [RFCv2 2/2] dma-buf: add helpers for sharing attacher constraints
 with dma-parms
In-Reply-To: <20150121173128.GV26493@n2100.arm.linux.org.uk>
References: <1421813807-9178-1-git-send-email-sumit.semwal@linaro.org>
 <1421813807-9178-3-git-send-email-sumit.semwal@linaro.org>
 <20150121173128.GV26493@n2100.arm.linux.org.uk>
Message-ID: <CAO_48GE4XQm+Fd9JUGzyw9fsFDSo6+fRY79vwS=Yjcw5GLZAJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell!

On 21 January 2015 at 23:01, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 21, 2015 at 09:46:47AM +0530, Sumit Semwal wrote:
>> +static int calc_constraints(struct device *dev,
>> +                         struct dma_buf_constraints *calc_cons)
>> +{
>> +     struct dma_buf_constraints cons = *calc_cons;
>> +
>> +     cons.dma_mask &= dma_get_mask(dev);
>
> I don't think this makes much sense when you consider that the DMA
> infrastructure supports buses with offsets.  The DMA mask is th
> upper limit of the _bus_ specific address, it is not a mask per-se.
>
> What this means is that &= is not the right operation.  Moreover,
> simply comparing masks which could be from devices on unrelated
> buses doesn't make sense either.
>
> However, that said, I don't have an answer for what you want to
> achieve here.

Thanks for your comments! I suppose in that case, I will leave out the
*dma_masks from this constraints information for now; we can re-visit
it when a specific use case really needs information about the
dma-masks of the attached devices.

I will post an updated patch-set soon.
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
Thanks and regards,

Sumit Semwal
Kernel Team Lead - Linaro Mobile Group
Linaro.org ? Open source software for ARM SoCs
