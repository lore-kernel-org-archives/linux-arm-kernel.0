From: p.paneri@samsung.com (Praveen Paneri)
Date: Thu, 9 Aug 2012 15:30:11 +0530
Subject: [PATCH v3 2/5] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <20120809092938.GK12174@arwen.pp.htv.fi>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <1344411661-17821-3-git-send-email-p.paneri@samsung.com>
 <20120809092938.GK12174@arwen.pp.htv.fi>
Message-ID: <CAD6zSYOU2Adz1dPjEjTEqp3L09Hmxd6Qu1AGL-1D8bvcLv_f3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 2:59 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Aug 08, 2012 at 01:10:58PM +0530, Praveen Paneri wrote:
>> @@ -3689,6 +3706,9 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
>>       s3c_hsotg_phy_disable(hsotg);
>>       regulator_bulk_free(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
>>
>> +     if (hsotg->phy)
>> +             devm_usb_put_phy(&pdev->dev, hsotg->phy);
>
> unnecessary. This will be called for you when the platform_device object
> is detroyed.
Off-course, I will remove this.

Thanks
Praveen
>
> --
> balbi
