From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 17 Feb 2014 15:27:01 +0530
Subject: [PATCH v3 1/3] dma: Support multiple interleaved frames with
 non-contiguous memory
In-Reply-To: <1392465619-27614-2-git-send-email-sthokal@xilinx.com>
References: <1392465619-27614-1-git-send-email-sthokal@xilinx.com>
 <1392465619-27614-2-git-send-email-sthokal@xilinx.com>
Message-ID: <CAJe_Zhc_GNNSDWNFuk+cMHEqxfSCJB_ey=Bf+SwJK-nS=u9ceg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2014 17:30, Srikanth Thokala <sthokal@xilinx.com> wrote:
> The current implementation of interleaved DMA API support multiple
> frames only when the memory is contiguous by incrementing src_start/
> dst_start members of interleaved template.
>
> But, when the memory is non-contiguous it will restrict slave device
> to not submit multiple frames in a batch.  This patch handles this
> issue by allowing the slave device to send array of interleaved dma
> templates each having a different memory location.
>
How fragmented could be memory in your case? Is it inefficient to
submit separate transfers for each segment/frame?
It will help if you could give a typical example (chunk size and gap
in bytes) of what you worry about.

Thanks,
Jassi
