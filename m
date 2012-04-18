From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 18 Apr 2012 20:43:40 +0530
Subject: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
In-Reply-To: <87bompp2bk.fsf@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
 <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
 <87bomprjic.fsf@ti.com> <4F8E62D2.9080206@ti.com> <87bompp2bk.fsf@ti.com>
Message-ID: <4F8EDA24.5020209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012 07:30 PM, Kevin Hilman wrote:
>>>> >>>  		if (ret < 0) {
>>>> >>>  			serial_omap_enable_ier_thri(up);
>>>> >>> +			pm_runtime_mark_last_busy(&up->pdev->dev);
>>>> >>> +			pm_runtime_put_autosuspend(&up->pdev->dev);
>>> >> Why the autosuspend version here?
>>> >>
>>> >> Kevin
>>> >>
>>> >>
>> > In case the request_dma fails we enable the thri( effectively like intr
>> > mode) so
>> > I thought of using the autosuspend version here .
>> >
>> > Do you prefer put version instead ?
> Not necessarily, it should just be well described in the changelog.
>
> Kevin
Yes agree completely. Will describe that in the changelog.
