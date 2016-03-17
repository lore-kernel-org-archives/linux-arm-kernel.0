From: david@lechnology.com (David Lechner)
Date: Thu, 17 Mar 2016 12:38:12 -0500
Subject: [PATCH v2 11/11] usb: musb: da8xx: Remove mach code
In-Reply-To: <56EAAD09.3080600@cogentembedded.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-12-git-send-email-david@lechnology.com>
 <56EAAD09.3080600@cogentembedded.com>
Message-ID: <56EAEB84.8060005@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2016 08:11 AM, Sergei Shtylyov wrote:
> On 3/17/2016 5:26 AM, David Lechner wrote:
>>
>>       glue->dev            = &pdev->dev;
>>       pdata->platform_ops        = &da8xx_ops;
>>
>> -    glue->phy = usb_phy_generic_register();
>> -    if (IS_ERR(glue->phy)) {
>> -        ret = PTR_ERR(glue->phy);
>> -        goto err5;
>> +    glue->usb_phy = usb_phy_generic_register();
>
>     Hm, do we still need the USB PHY? It does nothing IIRC...
>

Unfortunately, yes. It is used in musb_core, etc., mainly for otg->state.
