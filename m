From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Oct 2015 06:09:25 +0100
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU
 interrupts at resume time
In-Reply-To: <CAPv3WKc8bzCadNN=SRxQuJBxMiHTVKnmqaSkTehu=j6V4nF6Gg@mail.gmail.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPv3WKdZeCo-0xFC6EJcCeVQd7ef+SQz=MocR1nE5YdZAx3AJQ@mail.gmail.com>
 <20151026011036.2cb5b7a8@free-electrons.com>
 <CAPv3WKc8bzCadNN=SRxQuJBxMiHTVKnmqaSkTehu=j6V4nF6Gg@mail.gmail.com>
Message-ID: <20151026060925.32ff2034@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcin,

On Mon, 26 Oct 2015 05:35:46 +0100, Marcin Wojtas wrote:

> Thanks for the explanation - now it's clear.

Good :-) Hopefully the explanation in PATCH 5/5 is also clear enough.

> Btw, I checked the patches with mvneta in both 'standby' and 'mem'
> modes on A38x (with not-yet-submitted support for PM in mvneta and
> pinctrl) and everything works properly. Hence:

Thanks for the testing. However, I wonder why you think those changes
are need to get mvneta to work fine with the 'standby' mode ? While I
do agree that they are need for the 'mem' mode, they shouldn't be
needed for the 'standby' mode. For now, the standby mode only puts the
CPU into deep-idle, and that's all: all devices remain powered on, and
they don't lose their state.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
