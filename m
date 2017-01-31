From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 11:42:33 +0000
Subject: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
In-Reply-To: <20170130174958.GA3496@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej>
 <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
 <20170130174958.GA3496@leverpostej>
Message-ID: <20170131114233.GB11191@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 05:49:59PM +0000, Mark Rutland wrote:
> On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:

> > And because Linux kernel is running on Non-secure EL1, so should we
> > skip "SECURE" timer in Linux?
> 
> I guess you mean by checking the GTx Common flags, to see if the timer
> is secure? Yes, we must skip those.
> 
> Looking further at this, the ACPI spec is sorely lacking any statement
> as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
> not clear if we can access anything in a frame, even if it is listed as
> being a non-secure timer.

Given CNTNSAR.NS<n> enables non-secure access to CNTACR<n>, I guess the
obvious interpretation is that for frames listed as non-secure, this has
been configured to permit non-secure access to the frame and associated
CNTACR<n>.

I will work to that assumption while reviewing, though I still believe
this needs to be clarified in the spec.

Thanks,
Mark.
