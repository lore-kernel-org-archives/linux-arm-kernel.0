From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 May 2013 17:37:44 +0200
Subject: [PATCH] gpio: mxs: Use set and clear capabilities of the gpio
 controller
In-Reply-To: <20130502024443.GE3442@S2101-09.ap.freescale.net>
References: <1367244438-5322-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130502024443.GE3442@S2101-09.ap.freescale.net>
Message-ID: <5194FD48.3010106@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Le 02/05/2013 04:44, Shawn Guo a ?crit :
> On Mon, Apr 29, 2013 at 04:07:18PM +0200, Maxime Ripard wrote:
>> The current driver doesn't use the set and clear registers found on the
>> mxs gpio controller.
>>
>> This leads the generic gpio controller to be using some internal value
>> to avoid looking up the value stored in the registers, making it behave
>> pretty much like a cache.
>>
>> This raises some coherency problem when a gpio is not modified by the
>> gpio controller, while it can easily be fixed by using the set and clear
>> registers.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Would you consider merging this patch?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
