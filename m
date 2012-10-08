From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 08 Oct 2012 09:55:55 +0200
Subject: [PATCH 0/4] cpufreq: db8500: Use platform data to provide cpufreq
 table
In-Reply-To: <CAPDyKFqqS4D4ZNDp3tFqE5t5iYOKCcaQYvyFsfGQa5U8bzWWag@mail.gmail.com>
References: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb-SWkysKGQrJBL1hJLucQ=aN59Sfxe6rxrvtR0HsOJ_g@mail.gmail.com>
 <CAPDyKFqqS4D4ZNDp3tFqE5t5iYOKCcaQYvyFsfGQa5U8bzWWag@mail.gmail.com>
Message-ID: <22882034.rFTeZimQOF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 of October 2012 12:12:05 Ulf Hansson wrote:
> On 2 October 2012 13:45, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Sep 28, 2012 at 4:16 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> >
> >> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> Since the cpufreq table is dependant on the prmcu fw, it make sense to
> >> keep the table there. Moreover since the cpufreq is already a mfd child
> >> device added by the prcmu this make even more logic.
> >
> > Better there than elsewhere.
> >
> >> The next step after these patches will be to implement an "arm_clk" to be
> >> used from cpufreq to update the opp instead of using the prcmu opp API directly.
> >> This will then remove the last hard dependency to the prcmu API from cpufreq.
> >
> > Sounds like a plan.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Is this going to be merged through the cpufreq tree or the MFD tree?
> 
> Good question! Actually I would prefer to go through Mike Turquette
> clock tree, if he feel it is OK of course.
> My idea is then get the Ack from Rafael for cpufreq patches and from
> Samuel for the mfd patches.
> 
> The reason for doing this in a quite complicated manner is that my
> soon upcoming clock and mfd patches will functionality wise depend on
> these patches, and don't want to be sitting around and waiting for a
> new rc before being able to push the next series.

The cpufreq patches look good to me, please feel free to tag them as ACKed by me.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
