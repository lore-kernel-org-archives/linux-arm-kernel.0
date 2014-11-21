From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 21 Nov 2014 22:40:05 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <CAJKbBDD=eYmU=LuViwLPNV=kYCziDQgKjL07bT7og4vsj0Ee7A@mail.gmail.com>
References: <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
 <20141120144028.GB5809@localhost.localdomain>
 <546F2BA4.4000808@ti.com>
 <20141121131036.GA18931@localhost.localdomain>
 <CAJKbBDDVTA+=priRu7sCD=vHrC8AUg4DM3kycuGrqbpF-5FGAA@mail.gmail.com>
 <546F5C27.7040004@ti.com>
 <CAJKbBDD=eYmU=LuViwLPNV=kYCziDQgKjL07bT7og4vsj0Ee7A@mail.gmail.com>
Message-ID: <20141121214005.GA4020@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 07:17:18PM +0100, Johannes Pointner wrote:
> Before the patches were also jumps but I thought it is something
> Vignesh should know. Maybe there is some fix for that too?
> As Richard also noted, it would be nice if ti could let us know how to
> get the delay values right. By trial and error is IMHO not the best
> way.

That is not only an opinion, it is a matter of fact. TI really dropped
the ball on this one. I thought the patch series was a sign they
finally were going to properly address this issue. Wrong again.

The data sheet for the TI part used to have a reference to an app-note
for the touch controller.

      spruh73f page 1154

      The Pen IRQ can only occur if the correct Pen Ctrl bits are high
      (AFE Pen Ctrl bits 6:5 in the TSC_ADC control register) and if
      the correct ground transistor biasing is set in the StepConfig
      [N] Register. Refer to the application notes for the correct
      settings.

I searched high and low for this application note. Then, the data
sheet got revised.

Thanks,
Richard
