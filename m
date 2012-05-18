From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 May 2012 10:38:36 +0000
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <4FB57482.5060609@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <201205172122.05611.arnd@arndb.de> <4FB57482.5060609@linaro.org>
Message-ID: <201205181038.36949.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 May 2012, Lee Jones wrote:
> > I think the two options you have here are to either remove the ab8500 device from
> > mop500_platform_devs[] too (essentially registering mop500_gpio_keys_device
> > and ab8500_device separately when you need them, instead of doing the loop),
> > or to split u8500_local_bus_nodes so you use a different table for snowball
> > from the one you use for the other boards.
> 
> It's late here, so if I have the wrong end of the stick, just tell me ..
> 
> I figure that at the same time as enabling the other machines we'll be 
> stripping out the platform registrations in the same way as be have done 
> with Snowball. This will prevent two of anything from being registered 
> at any time.
> 
> Or am I mistaken?

Well, as far as I can tell, you duplicated a lot of functions or
data structures so you can remove the parts one by one, but when you
duplicated snowball_platform_devs[] you did not also duplicate
mop500_platform_devs[].

	Arnd
