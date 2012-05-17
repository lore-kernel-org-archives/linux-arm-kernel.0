From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 17 May 2012 09:47:08 -0500
Subject: [PATCH v4 5/7] ARM: imx: Add common imx cpuidle init
 functionality.
In-Reply-To: <20120516175515.GX30400@pengutronix.de>
References: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
 <1337135616-8988-6-git-send-email-rob.lee@linaro.org>
 <20120516175515.GX30400@pengutronix.de>
Message-ID: <CAMXH7KEj8LGZdPm_MsQif4RrsrnDJExYTJY4k9SCz7zzmgpAbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 12:55 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, May 15, 2012 at 09:33:34PM -0500, Robert Lee wrote:
>> Add common cpuidle init functionality that can be used by various
>> imx platforms.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> +
>> +#ifdef CONFIG_CPU_IDLE
>> +extern int imx_cpuidle_init(struct cpuidle_driver *drv);
>> +#else
>> +static inline int imx_cpuidle_init(struct cpuidle_driver *drv)
>> +{
>> + ? ? return -ENODEV;
>> +}
>> +#endif
>
> You should return succesfully here. Think about it, if imx_cpuidle_init
> fails you basically do nothing except maybe printing an error message
> which will be irritating when it appears on a kernel with cpuidle
> disabled.

Oops, yeah, I missed that.  Will fix in v5.

Thanks,
Rob

>
> Sascha
>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
