From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 14 Mar 2014 10:23:04 -0500
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <CAK=WgbYS+eJSTBXF=OeWjuL6iSbH+Y1RYewARKh9yAXHKKZ_cA@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com>
 <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
 <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
 <CAK=WgbYS+eJSTBXF=OeWjuL6iSbH+Y1RYewARKh9yAXHKKZ_cA@mail.gmail.com>
Message-ID: <20140314152304.GS18529@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 03:12:26PM +0200, Ohad Ben-Cohen wrote:
> On Sun, Mar 2, 2014 at 10:19 PM, Bjorn Andersson <bjorn@kryo.se> wrote:
> > When introducing the ability to reference a hwspin lock via a phandle
> > in device tree it makes a big difference to be able to differ between
> > the case of "initialization failed" or "device not yet probed"; so
> > that the client knows if it should fail or retry later.
> 
> I'm not convinced.
> 
> The only advantage this brings is to avoid retrying in case a fatal
> error has occurred. Such fatal errors are extremely rare, and when
> they show up - extremely painful, and I suspect that optimizing them
> wouldn't be a big win.

So, are you suggesting that because fatal errors should be "extremely
rare", a consuming driver should just assume that if NULL is returned
from a hwspin_lock_request*() function that it was the "device not yet
probed" case that was hit?

Note that having the consumer/hwspinlock device relationship modeled in
devicetree introduces more potential failure cases...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
