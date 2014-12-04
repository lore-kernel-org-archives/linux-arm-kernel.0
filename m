From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Dec 2014 11:54:52 +0100
Subject: [PATCH v2 0/4] VGIC early initialization initiated by user-space
In-Reply-To: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
References: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
Message-ID: <20141204105452.GB4526@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 10:48:00AM +0100, Eric Auger wrote:
> Since the advent of dynamic initialization of VGIC, this latter is
> initialized very late, on the first vcpu run. This initialization
> could be initiated much earlier by the user-space, as soon as it has
> set the requested dimensioning parameters: number of IRQs, number of
> vCPUs, base addresses.
> 
> One motivation behind being able to initialize the VGIC sooner is
> related to the setup of IRQ injection in VFIO use case. The VFIO
> signaling, especially when used along with irqfd must be set *after*
> vgic initialization to prevent any virtual IRQ injection before
> vgic initialization. If virtual IRQ injection occurs before the VGIC
> init, the IRQ cannot be injected and subsequent injection is blocked
> due to VFIO completion mechanism (unmask/mask or forward/unforward).
> 
The series looks overall pretty good to me.

-Christoffer
