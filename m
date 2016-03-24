From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Mar 2016 09:17:26 +0100
Subject: [PATCH 4/4] arm64: dts: marvell: Rename armada-ap806 XOR nodes
In-Reply-To: <1458771861-12392-5-git-send-email-afaerber@suse.de>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-5-git-send-email-afaerber@suse.de>
Message-ID: <20160324091726.6eaf83ec@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 23 Mar 2016 23:24:21 +0100, Andreas F?rber wrote:
> Node names should not contain an instance number, the unit address
> serves to distinguish nodes of the same name. So rename the XOR nodes
> to just xor at address, using xorX as label instead.
> 
> Fixes: ec7e5a569bce ("arm64: dts: marvell: add Device Tree files for Armada 7K/8K")
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Removing the instance number from the node name is obviously good.
However, I don't think it's really needed to add labels. The XOR
engines are purely "internal" devices, so they are always enabled at
the SoC level.

>  "marvell,mv-xor-v2" is not yet referenced from any driver in next-20160323.

Yes. The driver has been submitted, but has received some comments that
I need to address.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
