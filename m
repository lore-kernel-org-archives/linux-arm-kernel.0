From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 29 Apr 2016 09:40:10 +0200
Subject: [PATCH v2 00/11] pwm: Add support for PWM Capture
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160429094010.6bfb131c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, 22 Apr 2016 11:18:04 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> The first part of this set extends the current PWM API to allow external
> code to request a PWM Capture.  Subsequent patches then make use of the
> new API by providing a userspace offering via /sysfs.  The final part of
> the set supplies PWM Capture functionality into the already existing STi
> PWM driver.

Is there a reason you decided to not put this driver in IIO? IMHO, it
would be more appropriate to make your PWM device an MFD that can either
bind to the PWM or the capture driver.
And BTW, IIO already has a sysfs interface (you may have to extend the
API to support your type of capture though).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
