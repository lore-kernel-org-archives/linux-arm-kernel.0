From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 23 Nov 2011 11:05:41 +0100
Subject: [PATCH v2 1/2] MX2: Add platform definitions for eMMa-PrP device.
In-Reply-To: <4ECBF80C.20701@gmail.com>
References: <1321963316-9058-1-git-send-email-javier.martin@vista-silicon.com>
 <1321963316-9058-2-git-send-email-javier.martin@vista-silicon.com>
 <4ECBF80C.20701@gmail.com>
Message-ID: <CACKLOr1om8qwXL_pFr+aFGCh7paH-px9+FpmKNCPJyQmjf-zvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2011 20:29, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> Hi Javier,
>> +struct platform_device *__init imx_alloc_mx2_emmaprp(
>> + ? ? ? ? ? ? const struct imx_mx2_camera_data *data)
>> +{
>> + ? ? struct resource res[] = {
>> + ? ? ? ? ? ? {
>> + ? ? ? ? ? ? ? ? ? ? .start = data->iobaseemmaprp,
>> + ? ? ? ? ? ? ? ? ? ? .end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
>> + ? ? ? ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
>> + ? ? ? ? ? ? }, {
>> + ? ? ? ? ? ? ? ? ? ? .start = data->irqemmaprp,
>> + ? ? ? ? ? ? ? ? ? ? .end = data->irqemmaprp,
>> + ? ? ? ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
>> + ? ? ? ? ? ? },
>> + ? ? };
>> + ? ? struct platform_device *pdev;
>> + ? ? int ret = -ENOMEM;
>> +
>> + ? ? pdev = platform_device_alloc("m2m-emmaprp", 0);
>> + ? ? if (!pdev)
>> + ? ? ? ? ? ? goto err;
>> +
>> + ? ? ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
>> + ? ? if (ret)
>> + ? ? ? ? ? ? goto err;
>> +
>> + ? ? return pdev;
>> +err:
>> + ? ? platform_device_put(pdev);
>> + ? ? return ERR_PTR(-ENODEV);
>
> I guess you intended to have
>
> + ? ? ? return ERR_PTR(ret);

Sure, thanks for the tip.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
