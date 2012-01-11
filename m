From: timur@freescale.com (Timur Tabi)
Date: Wed, 11 Jan 2012 17:32:44 -0600
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0E1923.4090703@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <4F0DEE4F.3080103@freescale.com> <4F0E1923.4090703@firmworks.com>
Message-ID: <4F0E1C1C.70909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote:
> You make device nodes for each of the i2c adapters 

We have that already.

> (possibly with a GPIO 
> I2C mux node underneath the EDID one), 

Ok.

> then you point to the correct 
> adapter (or mux) node with a phandle-valued property in the video node.

The only connection between a device tree node and an I2C object is the
of_find_i2c_device_by_node() function.  That requires the I2C device to be
instantiated.

> Of course, you need the deferral patch cited in another message.

Last I heard, it's not ready.  I suspect it will be part of kernel 3.4, at
the earliest.

-- 
Timur Tabi
Linux kernel developer at Freescale
