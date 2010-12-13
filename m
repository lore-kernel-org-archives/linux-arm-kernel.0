From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 13 Dec 2010 12:08:15 -0600
Subject: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
In-Reply-To: <4D05D586.6090408@ti.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com>
	<4D05D586.6090408@ti.com>
Message-ID: <AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Mon, Dec 13, 2010 at 2:12 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Omar,
>
> On 12/11/2010 12:45 AM, Ramirez Luna, Omar wrote:
>>
>> Make the parameter received by omap_device_get_mpu_rt_va
>> consistent with the functions meant to be called by drivers.
>>
>> Also move its header declaration to appear in the set of
>> functions to be used by drivers, as per the comment there.
>
> Please note that even if Paul submitted this API upon request from Santosh,
> we do not want driver to us it most of the time.

Oh, ok. Yes, I was under the impression that this ioremap was internal
to hwmod, and drivers should do their own one; but then I noticed that
API and since it was under the "public functions through struct
platform data", I thought it was easier to pass pdev than od.

> All drivers should us the generic Linux way to get physical mem resource and
> then ioremap it.

Then I guess this function belongs to the "public for core code" and
not for drivers along with the omap_device_get_pwrdm.

> I assume that if you want to update this API, you are probably already using
> it.
> Why cannot you use the generic way?

I can leave the generic way along with ioremap, the purpose was to use
omap_device APIs as much as possible.

Thanks,

Omar
