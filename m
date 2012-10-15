From: jrudholm@gmail.com (Johan Rudholm)
Date: Mon, 15 Oct 2012 12:24:56 +0200
Subject: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
In-Reply-To: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CA+20K0CD_vizPB1DyJa8-bndWuapKmzx7DVq95fwd2MKedZb5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/12 Ulf Hansson <ulf.hansson@stericsson.com>:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant non power of two block sizes are supported.
> This will make it possible to decrease data overhead for SDIO
> transfers. Although we need to put some constraints to the alignment
> of the buffers when enabling this feature.
>
> Buffers must be 4 bytes aligned due to restrictions that the PL18x
> FIFO accesses must be done in a 4 byte aligned manner. Moreover we
> need to enable DMA_REQCTL for SDIO to support write of non 32 bytes
> aligned sg element lengths. In PIO mode any buffer length can be
> handled as long as the buffer address is 4 byte aligned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-By: Johan Rudholm <johan.rudholm@stericsson.com>
