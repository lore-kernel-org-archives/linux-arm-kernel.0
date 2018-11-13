From: john.stultz@linaro.org (John Stultz)
Date: Mon, 12 Nov 2018 16:07:03 -0800
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <20181109074955.GA27489@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
Message-ID: <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2018 at 11:49 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>
>> Any suggestions for how to further debug what might be going wrong
>> would be appreciated!
>
> Very odd.  In the end map_sg and map_page are defined to do the same
> things to start with.  The only real issue we had in this area was:
>
> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>
> so with current mainline + that you still see a problem, and if you
> rever the commit we are replying to it still goes away?

Just to confirm, as of 4.20-rc2 (which includes the of/device patch
above), I'm still seeing this issue, but it isn't as reliable to
reproduce as before.

With "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs" reverted
(along with the dependent swiotlb patches) it doesn't seem to trigger
(no matter what I try).  But re-applying that patch it tends to
trigger by itself at boot up, but sometimes I have to run "find /" to
trigger the io hang/stall.

thanks
-john
