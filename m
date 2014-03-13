From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 13 Mar 2014 11:43:15 -0500
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <53160F8F.9060405@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com>
 <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
 <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
 <53160F8F.9060405@ti.com>
Message-ID: <20140313164315.GQ18529@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 11:38:23AM -0600, Suman Anna wrote:
> Hi Ohad,
> 
> On 03/02/2014 02:19 PM, Bjorn Andersson wrote:
> >On Sat, Mar 1, 2014 at 9:14 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >>On Mon, Feb 10, 2014 at 9:14 PM, Suman Anna <s-anna@ti.com> wrote:
> >>>On 02/07/2014 04:49 PM, Bjorn Andersson wrote:
> >>>Ohad,
> >>>Do you have any objections to the return code convention change?
> >>
> >>Unless strictly needed, I prefer we don't switch to the ERR_PTR code
> >>convention, as it reduces code readability and increases chances of
> >>user bugs.
> >>
> >>In our case, switching to ERR_PTR and friends seems only to optimize a
> >>few error paths, and I'm not sure it's a big win over simplicity.
> >
> >When introducing the ability to reference a hwspin lock via a phandle
> >in device tree it makes a big difference to be able to differ between
> >the case of "initialization failed" or "device not yet probed"; so
> >that the client knows if it should fail or retry later.
> >
> 
> Can you confirm the changes you want me to make, so that I can refresh and
> post a v5 for 3.15?

What's the status on this?  I'm assuming this is going to miss 3.15?
Having DT support in the core will be useful to move the Qualcomm
hwspinlock driver forward as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
