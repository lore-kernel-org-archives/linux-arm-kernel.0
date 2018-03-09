From: jhogan@kernel.org (James Hogan)
Date: Fri, 9 Mar 2018 15:07:27 +0000
Subject: [PATCH v4 1/8] SOC: brcmstb: add memory API
In-Reply-To: <1516058925-46522-2-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-2-git-send-email-jim2101024@gmail.com>
Message-ID: <20180309150727.GH24558@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 06:28:38PM -0500, Jim Quinlan wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> This commit adds a memory API suitable for ascertaining the sizes of
> each of the N memory controllers in a Broadcom STB chip.  Its first
> user will be the Broadcom STB PCIe root complex driver, which needs
> to know these sizes to properly set up DMA mappings for inbound
> regions.
> 
> We cannot use memblock here or anything like what Linux provides
> because it collapses adjacent regions within a larger block, and here
> we actually need per-memory controller addresses and sizes, which is
> why we resort to manual DT parsing.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> 
> Conflicts:
> 	drivers/soc/bcm/brcmstb/Makefile

That can go.

> +++ b/drivers/soc/bcm/brcmstb/memory.c
...
> +/* Macro to help extract property data */
> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(*(u32*)(b + offs)))

Checkpatch complains about missing whitespace after u32.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/b6615c86/attachment-0001.sig>
