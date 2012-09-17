From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 17 Sep 2012 15:36:56 +0200
Subject: [PATCH 26/34] media: mx2_camera: remove dead code in
 mx2_camera_add_device
In-Reply-To: <Pine.LNX.4.64.1209171017460.1689@axis700.grange>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-27-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1209171017460.1689@axis700.grange>
Message-ID: <CACKLOr3BtK=tPMXTq21EAhX0579CXX=k_NN21vHGtvMW5DniHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2012 10:18, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Shawn
>
> Thanks for the clean up. Would you like these patches to go via a single
> tree, presumably, arm-soc? In this case
>
> On Mon, 17 Sep 2012, Shawn Guo wrote:
>
>> This is a piece of code becoming dead since commit 2c9ba37 ([media]
>> V4L: mx2_camera: remove unsupported i.MX27 DMA mode, make EMMA
>> mandatory).  It should have been removed together with the commit.
>> Remove it now.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> Cc: linux-media at vger.kernel.org
>
Acked-by: Javier Martin <javier.martin@vista-silicon.com>


> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Thanks
> Guennadi
>
>> ---
>>  drivers/media/video/mx2_camera.c |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/video/mx2_camera.c b/drivers/media/video/mx2_camera.c
>> index 965427f..89c7e28 100644
>> --- a/drivers/media/video/mx2_camera.c
>> +++ b/drivers/media/video/mx2_camera.c
>> @@ -441,11 +441,9 @@ static int mx2_camera_add_device(struct soc_camera_device *icd)
>>
>>       csicr1 = CSICR1_MCLKEN;
>>
>> -     if (cpu_is_mx27()) {
>> +     if (cpu_is_mx27())
>>               csicr1 |= CSICR1_PRP_IF_EN | CSICR1_FCC |
>>                       CSICR1_RXFF_LEVEL(0);
>> -     } else if (cpu_is_mx27())
>> -             csicr1 |= CSICR1_SOF_INTEN | CSICR1_RXFF_LEVEL(2);
>>
>>       pcdev->csicr1 = csicr1;
>>       writel(pcdev->csicr1, pcdev->base_csi + CSICR1);
>> --
>> 1.7.9.5
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
