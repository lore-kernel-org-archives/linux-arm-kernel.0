From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Apr 2014 09:30:33 -0700
Subject: [PATCH 1/1] ARM: dts: omap3-igep0020: use SMSC9221 timings
In-Reply-To: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140425163033.GC20807@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140424 09:54]:
> The IGEPv2 board has a SMSC LAN9221i ethernet chip and not a
> SMSC LAN911x connected to the GPMC. Each chip needs different
> timings in order to operate correctly so is wrong to include
> omap-gpmc-smsc911x.dtsi instead of omap-gpmc-smsc9221.dtsi.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Hi Tony,
> 
> I see no performance difference when measuring network throughput using
> iperf(1) but this change is the correct one nonetheless since if we later
> better adjust the timings it will already include the right dtsi.

Yes, let's fix this as wrong timings can cause memory corruption.
Applying into omap-for-v3.15/fixes-v2.

Tony
