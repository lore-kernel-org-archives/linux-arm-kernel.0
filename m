From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 20 Jun 2012 09:33:05 -0500
Subject: [PATCH v5] ARM: imx: Add basic imx6q cpu thermal management
In-Reply-To: <20120620142044.GU28394@pengutronix.de>
References: <1340175964-4043-1-git-send-email-rob.lee@linaro.org>
 <1340175964-4043-2-git-send-email-rob.lee@linaro.org>
 <20120620101127.GS28394@pengutronix.de>
 <CAMXH7KE0Ei5cZLCOuO-hxBXW8WX48VhxNs2FxPV8biDNqzRY5A@mail.gmail.com>
 <20120620142044.GU28394@pengutronix.de>
Message-ID: <CAMXH7KHJ5LHCZM2iY_mRm=1L2B5cdxPD_B0htRwX_1HBfn1oxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 9:20 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Jun 20, 2012 at 09:12:51AM -0500, Rob Lee wrote:
>> Sascha, thanks for the review.
>>
>> >> +
>> >> +static struct imx6q_thermal_zone ? ? *th_zone;
>> >> +static void __iomem ? ? ? ? ? ? ? ? ?*ocotp_base;
>> >
>> > This is a driver and drivers should generally be multi instance safe.
>> >
>>
>> I don't understand what this comment is referring to. ?Could you elaborate?
>
> Drivers can only be multi instance safe when all variables are inside a
> instance specific struct and you pass a pointer to this struct around.
> What if the i.MX7 has two different ocotp_base and you want to use this
> driver on both ocotp?
>

Understood, thanks.  I'll fix this in v6.

> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
