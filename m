From: balajitk@ti.com (Balaji T K)
Date: Fri, 7 Jun 2013 19:06:07 +0530
Subject: [PATCH 09/11] mmc: omap_hsmmc: enhance pinctrl support
In-Reply-To: <20130604144632.GI3331@atomide.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-10-git-send-email-gururaja.hebbar@ti.com>
 <20130604144632.GI3331@atomide.com>
Message-ID: <51B1E1C7.7050407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 08:16 PM, Tony Lindgren wrote:
> * Hebbar Gururaja <gururaja.hebbar@ti.com> [130531 03:19]:
>> Amend the hsmmc controller to optionally take a pin control handle and
>> set the state of the pins to:
>>
>> - "default" on boot, resume and before performing a mmc transfer
>> - "idle" after initial default, after resume default, and after each
>> mmc/sd card access
>> - "sleep" on suspend()
>>
>> By optionally putting the pins into sleep state in the suspend callback
>> we can accomplish two things.
>> - One is to minimize current leakage from pins and thus save power,
>> - second, we can prevent the IP from driving pins output in an
>> uncontrolled manner, which may happen if the power domain drops the
>> domain regulator.
>>
>> If any of the above pin states are missing in dt, a warning message
>> about the missing state is displayed.
>> If certain pin-states are not available, to remove this warning message
>> pass respective state name with null phandler.
>
> There's a similar patch in the "[RESEND PATCH v2 1/3] mmc: omap_hsmmc:
> Enable SDIO IRQ using a GPIO in idle mode" thread. It also makes the
> SDIO interrupts to work, so we need to consider that too.
>

Hi Tony,

I will try to combine both of these and make use of
pinctrl_pm_select_[*]_state helper functions.


> We can merge the dynamic pinmuxing parts separately, but they should
> be in a separate function like I posted later on in the thread above.
>
> Regards,
>
> Tony
>
