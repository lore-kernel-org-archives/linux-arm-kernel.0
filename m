From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 22 Sep 2011 13:25:36 +0530
Subject: [PATCH v5 09/15] OMAP2+: UART: Add runtime pm support for
	omap-serial driver
In-Reply-To: <CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
References: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
	<1316607206-21669-7-git-send-email-govindraj.raja@ti.com>
	<CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
Message-ID: <CAAL8m4zzynRm+c1xiwu117OkkX4X2ERoTDBPDL7XsihVcEL53g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 1:18 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Wed, Sep 21, 2011 at 8:13 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>> Adapts omap-serial driver to use pm_runtime API's.
>
>> ? ? ? ?console_unlock();
>>
>> - ? ? ? if ((cpu_is_omap34xx() && bdata->pads) ||
>> - ? ? ? ? ? ? ? (pdata->wk_en && pdata->wk_mask))
>> + ? ? ? if ((cpu_is_omap34xx() && bdata->pads))
>> ? ? ? ? ? ? ? ?device_init_wakeup(&pdev->dev, true);
>
> Just a bit curious, why doesn't the code enable wakeup at default
> on omap4, which will disable runtime pm of serial port on omap4.
>

yes sure will add for omap4.


> I have tested your patches on omap4 panda(enable wakeup at
> default manually), runtime pm of serial port 2 can work well and
> remote wakeup too.
>

Thanks, for testing.

--
Govindraj.R
