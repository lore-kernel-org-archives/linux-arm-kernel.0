From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 13:57:20 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0E0113.9090703@freescale.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0DF1E6.40602@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
 <4F0E0113.9090703@freescale.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A7C0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur Tabi wrote at Wednesday, January 11, 2012 2:37 PM:
...
> I also noticed that the I2C interface is not enabled until after the console opens the framebuffer.
> That means it's impossible for EDID data to be available before the console switches to the video
> device.  That doesn't seem right.

I think what you need is this:

https://lkml.org/lkml/2011/10/7/14

That may not be the latest version of the patches; I'm not quite sure
what the status is right now.

Then, FB probe could be deferred until after I2C probe, and the EDID
would be available.

-- 
nvpublic
