From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 12 Jan 2012 17:24:30 +0200
Subject: [PATCH RFC] OMAP: I2C: Fix the mismatch of pm_runtime enable and
 disable
In-Reply-To: <4F0D9BE1.6070209@ti.com>
References: <1326288104-10544-1-git-send-email-shubhrajyoti@ti.com>
 <CANOLnONdYYybbSP143+TeLxjfdEg1krcZjHwf140Fm5Y8rHogA@mail.gmail.com>
 <4F0D9BE1.6070209@ti.com>
Message-ID: <CAMP44s3TUEU9rdc7m73yEDrUu=-TgesypiBg=iVtg+gXodSfYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 4:25 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
> On Wednesday 11 January 2012 07:29 PM, Grazvydas Ignotas wrote:
>> On Wed, Jan 11, 2012 at 3:21 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>>> Currently the i2c driver calls the pm_runtime_enable and never
>>> the disable. This may cause a warning when pm_runtime_enable
>>> checks for the count match.Attempting to fix the same by calling
>>> pm_runtime_disable in the error and the remove path.
>> I remember seeing Felipe doing the reverse to musb here:
>> http://marc.info/?l=linux-omap&m=132432610700952&w=2
>> so I'm confused here.
> Strange however ?I see many drivers doing the same in the kernel
> on greping . Besides I expect a warn to come up.
>
> Felipe could you explain the issue?

When do you see the warning? kfree(dev) should disable runtime pm, but
without waking up the device.

-- 
Felipe Contreras
