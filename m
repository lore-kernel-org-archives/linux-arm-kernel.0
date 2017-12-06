From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 6 Dec 2017 04:11:12 +0000
Subject: [PATCH v6 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <CY1PR02MB169299C7AA719D4CE56F328DDC3B0@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1484372155-19423-1-git-send-email-appanad@xilinx.com>
 <1484372155-19423-3-git-send-email-appanad@xilinx.com>
 <296cffff-3847-4217-bd94-ac72fe044f73@topic.nl>
 <CY1PR02MB169299C7AA719D4CE56F328DDC3B0@CY1PR02MB1692.namprd02.prod.outlook.com>
Message-ID: <CY1PR02MB1692CA130CB5721CE6AC9425DC320@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike Looijmans,

	Thanks for the review...
	Sorry for the long delay in the reply...
Please find comments inline... 

<Snip>
>On 14-01-17 06:35, Kedareswara rao Appana wrote:
>>??When VDMA is configured for more than one frame in the h/w.
>>??For example h/w is configured for n number of frames, user
>>??Submits n number of frames and triggered the DMA using issue_pending API.
>>
>>??In the current driver flow we are submitting one frame at a time,
>>??But we should submit all the n number of frames at one time
>>??As the h/w is configured for n number of frames.
>
>The hardware can always handle a single frame submission, by using the "park"
>bit. This would make a good "cyclic" implementation too (using vdma as
>framebuffer).
>
>It could also handle all cases for "k" frames where n%k==0 (n is a multiple of
>k) by simply replicating the frame pointers.

Agree with your comments will fix it in the next version.
Somehow didn't get enough time to send next version of the patch series.
Will modify the driver as per your comments and will post next version of the patch series at the earliest... 

Regards,
Kedar.
