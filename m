From: sricharan@codeaurora.org (Sricharan)
Date: Thu, 27 Oct 2016 09:07:23 +0530
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <a3d4533f-165d-f444-7681-141479617a18@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
 <a3d4533f-165d-f444-7681-141479617a18@arm.com>
Message-ID: <004c01d23003$7230ed90$5692c8b0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>-----Original Message-----
>From: Robin Murphy [mailto:robin.murphy at arm.com]
>Sent: Wednesday, October 26, 2016 8:37 PM
>To: Sricharan R <sricharan@codeaurora.org>; will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org; linux-arm-
>kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; laurent.pinchart at ideasonboard.com; m.szyprowski at samsung.com;
>tfiga at chromium.org; srinivas.kandagatla at linaro.org
>Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
>
>On 04/10/16 18:03, Sricharan R wrote:
>> The dma_ops for the device is not getting set to NULL in
>> arch_tear_down_dma_ops and this causes an issue when the
>> device's probe gets deferred and retried. So reset the
>> dma_ops to NULL.
>
>Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>

 Thanks.

>This seems like it could stand independently from the rest of the series
>- might be worth rewording the commit message to more general terms,
>i.e. arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
>thus clearing the ops set by the latter, and sending it to Russell as a
>fix in its own right.

  Ok, will reword the commit log and push this separately.

Regards,
 Sricharan
