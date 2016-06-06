From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jun 2016 16:32:31 +0100
Subject: [PATCH v2 00/11] pwm: Add support for PWM Capture
In-Reply-To: <20160429094010.6bfb131c@bbrezillon>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <20160429094010.6bfb131c@bbrezillon>
Message-ID: <20160606153231.GE1525@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2016, Boris Brezillon wrote:

> Hi Lee,
> 
> On Fri, 22 Apr 2016 11:18:04 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The first part of this set extends the current PWM API to allow external
> > code to request a PWM Capture.  Subsequent patches then make use of the
> > new API by providing a userspace offering via /sysfs.  The final part of
> > the set supplies PWM Capture functionality into the already existing STi
> > PWM driver.
> 
> Is there a reason you decided to not put this driver in IIO? IMHO, it
> would be more appropriate to make your PWM device an MFD that can either
> bind to the PWM or the capture driver.
> And BTW, IIO already has a sysfs interface (you may have to extend the
> API to support your type of capture though).

Multi-Function Device drivers can only be justified if the IP
contained does not and can not live in a single subsystem.  The IP
which controls both PWM-in and PWM-out in this device is the same.  I
can't fathom a sane reason why you would wish to separate this
functionality over multiple subsystems.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
