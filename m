From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 1 Apr 2016 11:00:34 +0200
Subject: [RFC PATCH 40/45] KVM: arm/arm64: vgic-new: vgic_init: implement
 vgic_init
In-Reply-To: <56FE2F6B.5000508@linaro.org>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
 <1458871508-17279-41-git-send-email-andre.przywara@arm.com>
 <20160331175930.GF4126@cbox> <56FE2F6B.5000508@linaro.org>
Message-ID: <20160401090034.GA20224@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 10:20:59AM +0200, Eric Auger wrote:
> Hi Christoffer,
> On 03/31/2016 07:59 PM, Christoffer Dall wrote:
> > On Fri, Mar 25, 2016 at 02:05:03AM +0000, Andre Przywara wrote:
> >> From: Eric Auger <eric.auger@linaro.org>
> >>
> >> This patch allocates and initializes the data structures used
> >> to model the vgic distributor and virtual cpu interfaces. At that
> >> stage the number of IRQs and number of virtual CPUs is frozen.
> >>
> >> The following realy_init functions are kept since they are called from
> >> arm.c. However they may disappear in subsequent patches since
> >> they are void.
> >>
> >> vgic_[v2|v3]_enable still is stubbed at this stage.
> > 
> > early init ?
> Indeed I can mention those functions also are stubbed. Eventually it may
> make sense to remove their call from arm.c but this was not done yet in
> this series to avoid touching non vgic code.

oh, my comment was to the fact that you wrote realy_init above... :)

-Christoffer
