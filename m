From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 8 Oct 2012 11:18:02 +0200
Subject: [PATCH 2/2] [media]: mx2_camera: Fix regression caused by clock
 conversion
In-Reply-To: <Pine.LNX.4.64.1210081108130.12203@axis700.grange>
References: <1349473981-15084-1-git-send-email-fabio.estevam@freescale.com>
 <Pine.LNX.4.64.1210081108130.12203@axis700.grange>
Message-ID: <CACKLOr25nBY1VPWhLZYv7AOM4tXS8wJjqp_e-wjXHNdDJRiRuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2012 11:09, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Fabio
>
> On Fri, 5 Oct 2012, Fabio Estevam wrote:
>
>> Since mx27 transitioned to the commmon clock framework in 3.5, the correct way
>> to acquire the csi clock is to get csi_ahb and csi_per clocks separately.
>>
>> By not doing so the camera sensor does not probe correctly:
>>
>> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
>> mx2-camera mx2-camera.0: Camera driver attached to camera 0
>> ov2640 0-0030: Product ID error fb:fb
>> mx2-camera mx2-camera.0: Camera driver detached from camera 0
>> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 66500000
>>
>> Adapt the mx2_camera driver to the new clock framework and make it functional
>> again.
>
> Do I understand it right, that since the driver is currently broken, it
> doesn't matter any more in which order these two patches get applied, so,
> we can push them via different trees - ARM and media?
>
> Thanks
> Guennadi
>

Please,
hold on a couple of days before merging this one.

This driver is currently working in our Visstrim M10 platform without
this patch and I need to test it to confirm whether it breaks
something or not.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
