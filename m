From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Jan 2015 16:32:31 +0000
Subject: [PATCH v2 RESEND 2/8] irqchip: Supply new driver for STi based
 devices
In-Reply-To: <alpine.DEB.2.11.1501231702280.5526@nanos>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
 <1421920133-7914-3-git-send-email-lee.jones@linaro.org>
 <alpine.DEB.2.11.1501231702280.5526@nanos>
Message-ID: <20150123163231.GB11745@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015, Thomas Gleixner wrote:
> On Thu, 22 Jan 2015, Lee Jones wrote:
> 
> > This driver is used to enable System Configuration Register controlled
> > External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
> > Cache IRQs prior to use.
> 
> I'm wondering how this is related to irq_chip, 

It doesn't really.  At least, it doesn't make use of the framework.  
It was the most relevant subsystem.

> but well, I don't mind it being parked here.

Thanks Thomas.  I was hoping for that response.

> Though I really cannot say anything about this DT translation
> machinery for a single sysconfig register, other than it looks
> completely overengineered to me.

I understnad where you're coming from, but don't all drivers just
'twiddle some register bits'?

> The only technical comment I have is: shouldn't all the stuff except
> the resume function be marked __init or is any of this required post
> init?

It's not common to mark functions invoked at and affter *_probe() as
__init.  At least, not as far as I'm aware.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
