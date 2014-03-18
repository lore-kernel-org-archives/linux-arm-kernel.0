From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Mar 2014 13:37:12 +0000
Subject: arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <CAJ5Y-eZ5hWuph=K3dBUqSTSUr=O+dU4YayuVe30h4Uc7t-cczQ@mail.gmail.com>
References: <1395048095-32745-1-git-send-email-vkale@apm.com>
 <20140317103353.GD8070@e106331-lin.cambridge.arm.com>
 <CAPrCYkfxGVey_fQ47RO=XNnWYNM0qckdj9gMUZtZHkz6hR85xQ@mail.gmail.com>
 <CAJ5Y-eZ5hWuph=K3dBUqSTSUr=O+dU4YayuVe30h4Uc7t-cczQ@mail.gmail.com>
Message-ID: <20140318133712.GB2941@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 01:17:46PM +0000, Ashwin Chaugle wrote:
>    Hi Vinayak, Mark,
> 
>    On 17 March 2014 07:22, Vinayak Kale <[1]vkale@apm.com> wrote:
> 
>      > Do Potenza CPUs only have the PMUv3 events, and nothing
>      > Potenza-specific?
>      On top of PMUv3 events, Potenza CPU do have few implementation defined
>      events.
>      >
>      > I would have expected something like:
>      >
>      > compatible = "apm,potenza-pmu", "arm,armv8-pmuv3";
>      PMUv3 allows to have implementation defined events. And as such the
>      driver doesn't have any dependency on such events. Do you still think
>      we need additional compatible string for Potenza CPU?
> 
>    Can't these implementation specific events be used as raw perf events, or
>    extending that event space? (Or is that interface gone?) I may be missing
>    the details here, but I'm wondering if the method to program and count
>    these extra events is similar to ARM architected events, then why add
>    another DT binding?

It would be possible to use raw events, however that's a software level
detail, and not something that matters to the hardware description.

The hardware description should be as explicit as possible to allow the
software stack to change in future. For example, we might want to expose
implementation-specific events under sysfs in future, for which having
the implementation-specific compatible string in addition to the more
generic fallback is helpful.

This is why the compatible string exists. Making good use of it today
means a platform is more likely to have good support in future.

Having the string now is cheap, and makes it easier to tailor the
software stack more to the hardware in future. Not having the string
makes it harder. There is no reason not to have the more specific
compatible string.

Cheers,
Mark.
