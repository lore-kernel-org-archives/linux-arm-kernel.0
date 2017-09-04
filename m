From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 04 Sep 2017 15:34:25 +0200
Subject: rk3288: Enable HDMI hang boot and no Linux log
In-Reply-To: <CAD6G_RQqVJbPHosWV1YUf86-pK1YzvEYzy4=WG948iiXqbZw-w@mail.gmail.com>
References: <CAD6G_RQqVJbPHosWV1YUf86-pK1YzvEYzy4=WG948iiXqbZw-w@mail.gmail.com>
Message-ID: <2008140.oetUxFhdGh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 4. September 2017, 18:14:56 CEST schrieb Jagan Teki:
> Is linux-next support HDMI on rk3288? I'm trying to enable hdmi (with
> ddc-i2c-bus) statically along with Linux boot logo. Observed an kernel
> boot hang, didn't find whats wrong because DWC MHL PHY as detected
> from the log.

FWIW just checked something based on 4.13-rc7 on a rk3288-firefly and hdmi
is working nicely - as expected.

Also your kernel seems to stop at the stage where it hands over to the rootfs, 
so I'd guess your issue might be found in that area. The hdmi looks innocent 
regarding your issue.


Heiko


> Here is the full log[1] please let me know if I miss any?
> 
> Log:
> -----
> [    1.983832] rockchip-drm display-subsystem: bound ff930000.vop (ops
> 0xc0f53418)
> [    1.992170] rockchip-drm display-subsystem: bound ff940000.vop (ops
> 0xc0f53418)
> [    2.000416] dwhdmi-rockchip ff980000.hdmi: Detected HDMI TX
> controller v2.00a with HDCP (DWC MHL PHY)
> [    2.011210] rockchip-drm display-subsystem: bound ff980000.hdmi
> (ops 0xc0f551f4)
> [    2.019490] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    2.026888] [drm] No driver support for vblank timestamp query.
> [    2.033516] [drm] Cannot find any crtc or sizes
> [    2.038731] [drm] Initialized rockchip 1.0.0 20140818 for
> display-subsystem on minor 0
> [    2.047818] hctosys: unable to open rtc device (rtc0)
> [    2.053958]  mmcblk0: p1
> [    2.057009] ttyS2 - failed to request DMA
> 
> [1] https://paste.ubuntu.com/25464674/
> 
> thanks!
