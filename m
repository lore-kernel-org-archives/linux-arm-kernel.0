From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Thu, 22 May 2014 07:34:36 +0000
Subject: [PATCH] ARM: imx6: init enet MAC address
In-Reply-To: <20140522061229.GC32184@dragon>
References: <1400566266-22746-1-git-send-email-b38611@freescale.com>
 <20140522061229.GC32184@dragon>
Message-ID: <e1ceea0dac214195afe36f6434af6ba9@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com>
Data: Thursday, May 22, 2014 2:13 PM

>To: Duan Fugang-B38611
>Cc: Li Frank-B20596; linux-arm-kernel at lists.infradead.org;
>kernel at pengutronix.de
>Subject: Re: [PATCH] ARM: imx6: init enet MAC address
>
>On Tue, May 20, 2014 at 02:11:06PM +0800, Fugang Duan wrote:
>> Enet get MAC address order:
>> From module parameters or kernel command line -> device tree -> pfuse
>> -> mac registers set by bootloader -> random mac address.
>>
>> When there have no "fec.macaddr" parameters set in kernel command
>> line, enet driver get MAC address from device tree. And then if the
>> MAC address set in device tree and is valid, enet driver get MAC
>> address from device tree. Otherwise, enet get MAC address from pfuse.
>> So, in the condition, update the MAC address (read from pfuse) to
>> device tree.
>>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>
>I would think this is a board level configuration than SoC one.  Though
>the register name in Reference Manual, OCOTP_MAC0 and OCOTP_MAC1,
>recommends that these fuse bits can be used to store MAC address, it's
>really up to board designers how to use these fuse bits, e.g. how the MAC
>bytes will be stored in these 64 fuse bits, or on some board designs which
>do not have Ethernet interface at all, these bits can totally be used for
>other purpose.
>
>So to me, it's inappropriate to assume that these fuse bits always hold
>MAC address, and do this setup in kernel unconditionally for every board.
>I think it's more reasonable to do this setup in bootloader, which should
>be more board specific and can understand these fuse bits better.
>
>Shawn

Shawn,  if so, we don't need to upstream the patch in kernel.
Thanks for your information.

Andy
