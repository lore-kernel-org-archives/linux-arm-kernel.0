From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 19 Dec 2011 23:07:40 +0530
Subject: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
In-Reply-To: <4EEF6714.2040208@ti.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
 <20111216195002.GL32251@atomide.com>
 <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com>
 <20111216204123.GM32251@atomide.com>
 <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com>
 <20111217002409.GB6464@atomide.com> <4EED9DD4.3020506@ti.com>
 <4EEF6714.2040208@ti.com>
Message-ID: <4EEF7664.3000203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 December 2011 10:02 PM, Cousson, Benoit wrote:
> Hi Shubhro,
>
> On 12/18/2011 9:01 AM, Shubhrajyoti wrote:
>
> [...]
>
>> The driver does a reset in the error path.
>> Since we are not supposed to access the sysc reg the function is needed.
>
> I'm just wondering what will happen to the driver if this callback is
> not provided during the device creation? This is what will happen
> during DT boot for example?
>
> Is it a mandatory function?
This is used in the recovery mechanism in case of errors like some one
holding the bus and not releasing it etc.

>
> Thanks,
> Benoit
