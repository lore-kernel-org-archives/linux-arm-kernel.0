From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 1 May 2016 18:42:52 +0200
Subject: [RFT PATCH 0/3] usb: misc: usb3503: Fix missing device when TFTP
 booting
In-Reply-To: <57262844.7060809@xs4all.nl>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <57247E50.1020000@xs4all.nl> <20160501131746.GA16766@kozik-lap>
 <57260E1E.70205@xs4all.nl> <57262844.7060809@xs4all.nl>
Message-ID: <20160501164252.GA3581@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01, 2016 at 06:01:08PM +0200, Hans Verkuil wrote:
> > Sorry, I meant the hanging issue I got in 4.6, not the ethernet issue.
> > I get the same problem with linux-next. Can you mail me the .config you are using?
> 
> Never mind.
> 
> > After some more testing I don't think it is hanging, instead it seems that the mmc
> > isn't enabled/found and so it just sits waiting for the root partition to appear.
> 
> That was fun. There are two problems that both caused the boot to end at the same
> place: first of all the root partition is now called mmcblk1p1 instead of mmcblk0p1
> in 4.6, so it was just waiting for the root partition to appear. Nothing to do with
> your patch series, just unexpected.

Yes, annoying issue and unfortunately this is known... recommended
solution is to use root=PARTUUID=xxxx (you can get the PARTUUID with
blkid)... or replace the mmc device.

> The second is that enabling CONFIG_VIDEO_S5P_FIMC causes the boot to hang at that
> same place. I suspect there is a deadlock somewhere. I'm digging deeper into that
> but again, unrelated to your patch series.
> 
> Anyway, after disabling that config option I was finally able to test your patch
> series:
> 
> Tested-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

Best regards,
Krzysztof
