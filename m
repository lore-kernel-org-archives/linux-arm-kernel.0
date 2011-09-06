From: robherring2@gmail.com (Rob Herring)
Date: Tue, 06 Sep 2011 08:31:59 -0500
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <CAKnu2MrFsnZrq-Fzq3HpV8oAwa9Vi6fFqrSSB7+kq8r8V7ANQg@mail.gmail.com>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
	<4E64496E.1090000@gmail.com>
	<CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
	<4E64EB24.7010800@gmail.com>
	<CAKnu2MrFsnZrq-Fzq3HpV8oAwa9Vi6fFqrSSB7+kq8r8V7ANQg@mail.gmail.com>
Message-ID: <4E6620CF.3020201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2011 12:25 AM, Linus Walleij wrote:
> 2011/9/5 Rob Herring <robherring2@gmail.com>:
> 
>>>> Should the VGA memory really be accessed before PCI host is initialized?
>>>
>>> I don' know, I don't know one bit about how PCI works and should
>>> work, you tell me :-)
>>
>> I guess it's normal (from init/main.c):
> 
> Ah. I've even seen that comment in main.c.
> 
> SHall I go over the other changes in the same and check for
> potential problems?
> 

Integrator and footbridge are the only platforms that would ever
actually work with VGA console because the others are all returning a
physical address rather than a virtual address. kirkwood, dove, mv78xx0,
and orion5x are all wrong. I'm not sure on shark. Seems to be a virtual
address, but it's not mapped.

So perhaps the correct fix is just to remove the initialization of
vga_base on all these platforms.

Rob
