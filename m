From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 8 Nov 2010 16:43:39 -0500
Subject: [PATCH v2 6/7] omap: mailbox: fix detection for previously
	supported chips
In-Reply-To: <AANLkTin+oBj6CTpWKB9ZBYRVjR_8_tPcY_Y4+T5PecRA@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>	<1289006244-27147-7-git-send-email-omar.ramirez@ti.com>	<4CD59A56.4070003@ti.com>
	<AANLkTin+oBj6CTpWKB9ZBYRVjR_8_tPcY_Y4+T5PecRA@mail.gmail.com>
Message-ID: <4CD86F0B.6060402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/2010 10:15 AM, Ramirez Luna, Omar wrote:
> On Sat, Nov 6, 2010 at 1:11 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> -#if defined(CONFIG_ARCH_OMAP3430)
>>> +#if defined(CONFIG_ARCH_OMAP3)
>>
>> Ideally you should get rid of all the CONFIG_ARCH_OMAPXXX or cpu_is_omap in
>> that code. This is a driver, it should be generic.
>> If you have to handle differences between OMAP version, please do that in
>> the devices, not in the driver.
>>
>> This patch just contains a few of them, but the original mailbox.c file is
>> full of that kind of test.
>> I know that you are not the original writer of this code, but since the
>> clean it, it will be good to remove all the legacy code.
>
> I mentioned it in the cover-letter, I should have put it here too, my bad.
>
> <quote>
> This is meant as a short term solution until proper cleanup is done,
> as suggested in:
>
> http://marc.info/?l=linux-arm-kernel&m=128534253231481&w=2
> </quote>

OK, sorry I didn't realized that this email thread was about the 
mailbox. I'm glad to see that both Paul and Nishant are aligned with me.

> Does nobody care that the driver is not working right now for some
> chips (since it was working before!!) and are willing to wait for more
> time until the proper cleanup is done?

Sorry again, but removing these tests didn't not seems to be a huge task 
for my point of view.
Anyway, if you want to do another phase and if everybody agree on that, 
that's OK for me as well.

> For me it is a hassle, because if I need to do something on 3630 I
> have to merge this patch, then apply what I'm working into, then
> remove the patch, apply everything again to see no dependencies are
> there, then send.

Yeah, sometime life really sucks :-)

Benoit
