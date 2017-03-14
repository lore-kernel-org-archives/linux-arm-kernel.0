From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 14 Mar 2017 09:56:35 -0700
Subject: [PATCH v6 0/4] Broadcom SBA RAID support
In-Reply-To: <1488793408-25592-1-git-send-email-anup.patel@broadcom.com>
References: <1488793408-25592-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <CAPcyv4hGGbhF-g8B__9=rsP+QwR6RBi=WqALLgABNb1M4D3rBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 1:43 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> The Broadcom SBA RAID is a stream-based device which provides
> RAID5/6 offload.
>
> It requires a SoC specific ring manager (such as Broadcom FlexRM
> ring manager) to provide ring-based programming interface. Due to
> this, the Broadcom SBA RAID driver (mailbox client) implements
> DMA device having one DMA channel using a set of mailbox channels
> provided by Broadcom SoC specific ring manager driver (mailbox
> controller).
>
> The Broadcom SBA RAID hardware requires PQ disk position instead
> of PQ disk coefficient. To address this, we have added raid_gflog
> table which will help driver to convert PQ disk coefficient to PQ
> disk position.
>
> This patchset is based on Linux-4.11-rc1 and depends on patchset
> "[PATCH v5 0/2] Broadcom FlexRM ring manager support"
>
> It is also available at sba-raid-v6 branch of
> https://github.com/Broadcom/arm64-linux.git
>
[..]
>
> Anup Patel (4):
>   lib/raid6: Add log-of-2 table for RAID6 HW requiring disk position
>   async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()
>   dmaengine: Add Broadcom SBA RAID driver
>   dt-bindings: Add DT bindings document for Broadcom SBA RAID driver

For the dmaengine and async_tx changes:

Acked-by: Dan Williams <dan.j.williams@intel.com>

The raid change should get an ack from Shaohua.
