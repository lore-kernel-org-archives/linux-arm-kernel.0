From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 18 Sep 2012 10:34:25 +0200
Subject: [PATCH 27/34] media: mx2_camera: use managed functions to clean
 up code
In-Reply-To: <20120918074315.GH1338@S2101-09.ap.freescale.net>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-28-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1209171110580.1689@axis700.grange>
 <CACKLOr1pa+kskDjFVJ6N++f4i5NMyEtjFELqrwqvaPR4ErXiNA@mail.gmail.com>
 <20120918074315.GH1338@S2101-09.ap.freescale.net>
Message-ID: <CACKLOr0C_x1qmN2bnw5cPFxPRRsJ5qNvvyLxdiQkoDyq76B3gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 18 September 2012 09:43, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Sep 17, 2012 at 03:36:07PM +0200, javier Martin wrote:
>> This patch breaks the driver:
>>
> Javier,
>
> Can you please apply the following change to see if it fixes the
> problem?
>
> Shawn
>
> @@ -1783,6 +1783,8 @@ static int __devinit mx2_camera_probe(struct platform_device *pdev)
>                         goto exit;
>         }
>
> +       platform_set_drvdata(pdev, NULL);
> +
>         pcdev->soc_host.drv_name        = MX2_CAM_DRV_NAME,
>         pcdev->soc_host.ops             = &mx2_soc_camera_host_ops,
>         pcdev->soc_host.priv            = pcdev;

Yes. That fixes the problem.

With this fix:

Tested-by: Javier Martin <javier.martin@vista-silicon.com>

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
