From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 Jul 2018 08:10:28 +0530
Subject: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
In-Reply-To: <5B4F5E00.5050800@hisilicon.com>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <5B4F5E00.5050800@hisilicon.com>
Message-ID: <20180719024028.vudrlpgxiz6accky@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-07-18, 16:34, Wei Xu wrote:
> Hi Viresh,
> 
> On 2018/7/5 6:09, Viresh Kumar wrote:
> > Hi,
> > 
> > This is an attempt to fix the broken or partially defined DT bindings
> > for cooling-maps. We should list every device that participates in
> > cooling down at a certain trip point, instead of just the first in the
> > list as that depends on certain ordering of events to work properly.
> > 
> > The first patch extends the binding to allow a list of phandles in
> > "cooling-device" property and the second patch fixes one of the
> > platform's DT.
> > 
> > This will be followed up by fixing all platform DT bindings that have
> > these issues after this set is accepted.
> > 
> > The kernel also requires some changes to handle the phandle list, but
> > wouldn't break with these changes as it reads the first phandle in the
> > list for now. We can update that separately.
> > 
> > --
> > viresh
> > 
> > Viresh Kumar (2):
> >   dt-bindings: thermal: Allow multiple devices to share cooling map
> >   arm64: dts: hi6220: Add all CPUs in cooling maps
> > 
> >  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> 
> Thanks!
> Applied both to the hisilicon dt tree.

Hi Wei,

I expected the first patch to go via the thermal tree as it is for the
thermal core maintainers. Second patch can very well go from your
tree, but only after the 1st one is applied by thermal maintainers.

-- 
viresh
