From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 24 May 2018 10:11:07 -0700
Subject: [PATCH v3 4/6] watchdog: sp805: set WDOG_HW_RUNNING when
 appropriate
In-Reply-To: <5e3d05f2-d526-9108-e2fd-13573458be85@broadcom.com>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-5-git-send-email-ray.jui@broadcom.com>
 <20180524161901.GB28425@roeck-us.net>
 <5e3d05f2-d526-9108-e2fd-13573458be85@broadcom.com>
Message-ID: <20180524171107.GB9499@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 09:36:25AM -0700, Ray Jui wrote:
> 
> 
> On 5/24/2018 9:19 AM, Guenter Roeck wrote:
> >On Wed, May 23, 2018 at 05:15:22PM -0700, Ray Jui wrote:
> >>If the watchdog hardware is already enabled during the boot process,
> >>when the Linux watchdog driver loads, it should reset the watchdog and
> >>tell the watchdog framework. As a result, ping can be generated from
> >>the watchdog framework, until the userspace watchdog daemon takes over
> >>control
> >>
> >>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> >>Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> >
> >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> >I have one question, though: Is it really correct that both
> >INT_ENABLE _and_ RESET_ENABLE have to be set to enable the watdog ?
> >What if only RESET_ENABLE is set ?
> 
> According to the SP805 TRM, INT_ENABLE needs to be set to high to enable the
> counter and the interrupt. Counter will be stopped if INT_ENABLE is cleared.
> So yes, INT_ENABLE needs to be set.
> 
Excellent, thanks for the clarification.

Guenter
