From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Thu, 5 May 2016 11:17:00 +0530
Subject: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
In-Reply-To: <CAGVrzcbCZn6RYFwJTkffkct1DiiG+tBJnKELDn32T38_s5mjOg@mail.gmail.com>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160406173140.GB38452@dtor-ws>
 <CAGVrzcbCZn6RYFwJTkffkct1DiiG+tBJnKELDn32T38_s5mjOg@mail.gmail.com>
Message-ID: <CAAFb_vp+oxHc6YD24zPr0o6Pt9Jt1_LsT14VUQGBKXBpvNAj_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Dmitry and Florian.

Hi Dmitry,

I understand the dts changes are really needed for the touch screen
driver changes made in this patch. But currently there are no deployed
systems/customer's using this driver. So please pull the driver changes
and I will follow up to make sure dts changes also goes in.

Below is the latest patch set pushed.

https://lkml.org/lkml/2016/3/24/45


Thanks ,
Raveendra

On Thu, Apr 7, 2016 at 1:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2016-04-06 10:31 GMT-07:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> On Sat, Feb 27, 2016 at 12:29:56PM +0530, Raveendra Padasalagi wrote:
>>> In Cygnus SOC touch screen controller registers are shared
>>> with ADC and flex timer. Using readl/writel could lead to
>>> race condition. So touchscreen driver is enhanced to support
>>> syscon based register access to take care of mutually exclusive
>>> access.
>>>
>>> This patch enables syscon support in touchscreen driver
>>> by adding necessary properties in touchscreen dt node and
>>> in addition to this renamed existing "tsc" touchscreen node
>>> name to "touchscreen".
>>>
>>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>
>> OK, since the new dts is really needed for the driver I'll be folding
>> this into the touchscreen driver patch unless I hear someone yelling at
>> me.
>
> Works for me:
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> --
> Florian
