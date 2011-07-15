From: olof@lixom.net (Olof Johansson)
Date: Fri, 15 Jul 2011 11:30:18 -0700
Subject: [PATCH 2/2] ARM: tegra: remove copy-and-pasted usb platform data
	from boards
In-Reply-To: <CAMbhsRTxAwKJ7qiK=_BAMc3Y1x_WHF7WHrm_54o-sYLBb1zzng@mail.gmail.com>
References: <1310336374-31727-1-git-send-email-ccross@android.com>
	<1310336374-31727-2-git-send-email-ccross@android.com>
	<20110715111348.3ed0522a@ac100.localdomain>
	<201107151155.56495.heiko@sntech.de>
	<CAMbhsRTxAwKJ7qiK=_BAMc3Y1x_WHF7WHrm_54o-sYLBb1zzng@mail.gmail.com>
Message-ID: <20110715183018.GA3083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 09:45:53AM -0700, Colin Cross wrote:
> Can you or someone else test if power_down_on_bus_suspend is causing a
> problem?  If it is, I'll change the default in devices.c to
> power_down_on_bus_suspend=0, and devices that want
> power_down_on_bus_suspend=1 will have to set it.

Seaboard and derivatives have power_down_on_bus_suspend set, and does OK with
that. I suggest that paz00 overrides the value before device registration if
it has to. If the number of boards down the road that need it off exceeds
number of boards that need it on, it can always be flipped. This should come
from the device tree later anyway.

(Note: I'll post a patch in a bit that keeps the IP clocked even if phy is
powered down on bus suspend, since otherwise we don't get hotplug events for
hub-less systems).


-Olof
