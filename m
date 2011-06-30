From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 30 Jun 2011 11:49:16 -0700
Subject: [PATCH 1/1] net/fec: iMX53 needs gasket for both MII and RMII
In-Reply-To: <20110630161935.GA7977@S2100-06.ap.freescale.net>
References: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110630161935.GA7977@S2100-06.ap.freescale.net>
Message-ID: <4E0CC52C.6010306@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/30/2011 9:19 AM, Shawn Guo wrote:
> Hi Troy,
> 
> On Wed, Jun 29, 2011 at 03:38:18PM -0700, Troy Kisky wrote:
>> Currently, only RMII interfaces are using the gasket.
>> But, the iMX53 needs to enable the gasket for MII
>> mode as well. The iMX51 has no gasket registers. So,
>> add a use_gasket field to fec_platform_data to not restrict
>> same kernel for both iMX51/53 boards.
>>
> 
> Right, on those early SoCs with fec, like imx27/35/51, there is no
> gasket, while on those recent ones, like imx25/50/53, there is gasket,
> and the gasket should be enabled for not only MII mode but also  RMII
> mode.  I guess you caught this problem when using a MII phy with
> imx53?
> 
> Though I agree this is something we need to fix, I'm unsure using
> platform_data is the best way.  IMO, this gasket is rather SoC
> specific thing than platform (board).  If we are running fec on
> imx25/50/53, we need to enable the gasket, no matter what boards
> we are using and how the boards are designed.
> 
> Since platform_device_id is already being used to distinguish imx28
> from other imx SoCs, maybe we can extend it to handle gasket too?
> 
> Regards,
> Shawn
> 
>> iMX28 boards don't need use_gasket, as they have
>> FEC_QUIRK_ENET_MAC.

When I saw how FEC_QUIRK_ENET_MAC was handled, it thought about changing
to do it that way. It really does look better that way. But the current
change looks more efficient memory-wise. Though, I guess that would
depend on how many boards your kernel supports and whether more option
are to be added later.

I'm fine with redoing your way if I can get a tentative OK first.

Is	.name = 'g-fec' OK?

Thanks
Troy
