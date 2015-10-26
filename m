From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Oct 2015 09:27:11 +0100
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU
 interrupts at resume time
In-Reply-To: <CAPv3WKcrWqJ5Cw_kwO+JWk3iH0aprTexHTqzy-dSFmNHj4xJcg@mail.gmail.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
 <20151026011036.2cb5b7a8@free-electrons.com>
 <CAPv3WKc8bzCadNN=SRxQuJBxMiHTVKnmqaSkTehu=j6V4nF6Gg@mail.gmail.com>
 <20151026060925.32ff2034@free-electrons.com>
 <CAPv3WKcrWqJ5Cw_kwO+JWk3iH0aprTexHTqzy-dSFmNHj4xJcg@mail.gmail.com>
Message-ID: <20151026092711.04193834@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Mon, 26 Oct 2015 08:06:18 +0100, Marcin Wojtas wrote:

> > Good :-) Hopefully the explanation in PATCH 5/5 is also clear enough.
> 
> The Ascii-art is beutiful, indeed:)

Glad to hear that my artistic skills are appreciated :)

> Yes, you are right - without any pm_ops the driver works well after
> suspend/resume in standby. However in the linux mem and standby is
> treated exactly the same as pm sleep, so the same routines are
> executed in both modes. Hence the s2ram support cannot spoil standby.

Absolutely. It would be nicer if we knew in the ->suspend() and
->resume() hooks if we're doing a standby suspend, or a mem suspend,
but IIRC, we don't have this information available.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
