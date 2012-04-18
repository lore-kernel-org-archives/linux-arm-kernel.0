From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Wed, 18 Apr 2012 21:05:56 +0530
Subject: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
In-Reply-To: <20120418152956.GP25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
Message-ID: <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji wrote:
>> Hi,
>>
>> drivers/mmc/host/omap.c is also using dma_mask should that also be removed
>
> Does this driver make use of this platform data?
>
> If so, it needs converting to DMA engine _before_ this patch (which is
> one reason why its a good idea to do these changes as separate patches...
> as I've done.) ?It means stuff like this can be slotted in as necessary
> in the patch order.
>
> I'm told that driver is OMAP2 only - I don't have any OMAP2 platforms to
> be able to test it on (I only have OMAP3 and OMAP4.)

Yes, this driver is for omap2420 and omap1 devices.
