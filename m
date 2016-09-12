From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Sep 2016 15:58:55 -0700
Subject: [PATCH v2 00/17] Make rpmsg a framework
In-Reply-To: <20160912222240.GA28944@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
 <20160912165233.GB21885@linaro.org>
 <20160912222240.GA28944@linaro.org>
Message-ID: <20160912225855.GL405@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Sep 15:22 PDT 2016, Lina Iyer wrote:

> On Mon, Sep 12 2016 at 10:52 -0600, Lina Iyer wrote:
> >Hi Bjorn,
> >
> >On Thu, Sep 01 2016 at 16:28 -0600, Bjorn Andersson wrote:
> >>This series splits the virtio rpmsg bus driver into a rpmsg bus and a virtio
> >>backend/wireformat.
> >>
> >>
> >>As we discussed the Qualcomm SMD implementation a couple of years back people
> >>suggested that I should make it "a rpmsg thingie". With the introduction of the
> >>Qualcomm 8996 platform, we must support a variant of the communication
> >>mechanism that share many of the characteristics of SMD, but are different
> >>enough that it can't be done in a single implementation. As such there is
> >>enough benefit to do the necessary work and being able to make SMD a "rpmsg
> >>thingie".
> >>
> >>On-top of this series I have patches to switch the current smd clients over to
> >>rpmsg (and by that drop the existing SMD implementation).
> >>
> >>All this allows me to implement the new backend and reuse all existing SMD
> >>drivers with the new mechanism.
> >>
> >
> >RPM Communication has to supported even when IRQs are disabled. The most
> >important use of this communication is to set the wake up time for the
> >CPU subsystem when all the CPUs are powered off. In addition to that,
> >"sleep" votes that are sent by the application processor subsystem to
> >allow system to go into deep sleep modes can only be triggered when the
> >CPU PM domains are power collapsed, drivers do not have a knowledge of
> >when that happens. This has to be done by a platform code that registers
> >for CPU PM domain power_off/on callbacks.
> >
> Ok, my bad. These two cases are not critical for the SoC supported by
> this driver. So you are good to go from cpuidle perspective
> 

Thanks for letting me know. Please keep me updated if you find any
changes to this.

Just to be clear, I'm not against supporting sending and receiving
messages in atomic context as long as it doesn't just add accidental
complexity.

Regards,
Bjorn
