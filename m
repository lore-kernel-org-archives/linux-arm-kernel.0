From: timur@freescale.com (Timur Tabi)
Date: Wed, 11 Jan 2012 14:17:19 -0600
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0D2F90.8020801@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
Message-ID: <4F0DEE4F.3080103@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote:

> I think that would not be a good design.  Presence and location of EDID 
> data is not something that a generic I2C driver should know.  It's the 
> video controller that knows that EDID exists, where it is located 
> (device ID 0x50 and addresses within that device), and what it means.

But the video driver does not know what I2C *bus* it's on.  I have been unable to come up with a way to obtain the proper i2c_adapter object to use when looking for EDID data.  

>>  That won't work if I have multiple video controllers, since I won't know which EDID data goes with which video controller.  I tried adding a call to i2c_add_driver() in my framebuffer driver, but the I2C probe function was called *after* the framebuffer's probe function, so that doesn't help me.
> 
> Then there needs to be some sort of ordering or dependency to ensure 
> that the I2C driver is activated before the framebuffer driver tries to 
> use it.

I don't know how to do that, either.

> Either way, you need platform-dependent functions to do the switching, 
> and you need to select the appropriate channel.  Personally, I don't see 
> the advantage of using the mux device in this case.  It's just adding 
> complexity with no payback.

I'm always in favor of doing things the simpler way.


-- 
Timur Tabi
Linux kernel developer at Freescale
