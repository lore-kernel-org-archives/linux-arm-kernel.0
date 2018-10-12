From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Oct 2018 10:09:38 +0100
Subject: DMA remote memcpy requests
In-Reply-To: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
Message-ID: <20181012090937.GA12289@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

[+Robin and Cavium folks -- it's usually best to cc people as well as
 mailing the list]

On Thu, Oct 11, 2018 at 07:28:37AM +0000, Adam Cottrel wrote:
> I am using the ATH10K on Linux 14.4 with an Arm Cavium processor. During
> heavy loading, I am seeing that target initiated DMA requests are being
> silently dropped under extreme IO memory pressure and it is proving very
> difficult to isolate the root cause.

Is this ThunderX 1 or 2 or something else? Can you reproduce the issue with
mainline?

> The ATH10K firmware uses the DMA API to set up phy_addr_t pointers
> (32-bit) which are then copied to a shared ring buffer. The target then
> initiates the memcpy operation (for target-to-host reads), but I do not
> have any means of debugging the target directly, and so I am looking for
> software hooks on the host that might help debug this complex problem.

How does the firmware use the DMA API, or are you referring to a driver? If
the latter, could you point us to the code, please? Is it using the
streaming API, or is this a coherent allocation?

> Please can someone explain the low-level operation of DMA once it becomes
> a target initiated memcpy function?

I think we need a better handle on the issue first.

> p.s. I have tested with and without the IOMMU, and I have eliminated
> issues such as cache coherency being the root cause.

Right, not sure how the SMMU would help here.

Will
