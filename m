From: treding@nvidia.com (Thierry Reding)
Date: Thu, 19 Nov 2015 16:30:59 +0100
Subject: [PATCH v3 2/5] dt-bindings: soc: add document for rockchip
 reboot notifier driver
In-Reply-To: <CANbgqASc1fyoV6FJ1g15P27_h0iA_F9h8aP304X8tRovrKrq5A@mail.gmail.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <1447840410-19794-1-git-send-email-andy.yan@rock-chips.com>
 <20151118225904.GA5429@rob-hp-laptop>
 <564D2331.8070503@rock-chips.com>
 <20151119125643.GE21862@ulmo.nvidia.com>
 <CANbgqASc1fyoV6FJ1g15P27_h0iA_F9h8aP304X8tRovrKrq5A@mail.gmail.com>
Message-ID: <20151119153057.GA12486@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 09:39:02PM +0800, Andy Yan wrote:
> Hi Thierry:
> 
> 2015-11-19 20:56 GMT+08:00 Thierry Reding <treding@nvidia.com>:
> 
> > On Thu, Nov 19, 2015 at 09:17:37AM +0800, Andy Yan wrote:
> > > Hi Rob:
> > >
> > > On 2015?11?19? 06:59, Rob Herring wrote:
> > > >On Wed, Nov 18, 2015 at 05:53:30PM +0800, Andy Yan wrote:
> > > >>Add devicetree binding document for rockchip reboot nofifier driver
> > > >Just reading the subject this is way too specific to the Linux driver
> > > >needs rather than a h/w description. Please don't create fake DT nodes
> > > >just to bind to drivers. Whatever &pmu is is probably what should have
> > > >the DT node. Let the driver for it create child devices if you need
> > > >that.
> > >
> > >     This is note a fake DT nodes, we really need it to tell the driver
> > >      which register to use to store the reboot mode. Because rockchip
> > >      use different register file to store the reboot mode on different
> > >      platform, on rk3066,rk3188, rk3288,it use  one of the PMU register,
> > on
> > >      the incoming RK3036, it use one of the GRF register, and it use
> > one  of
> > >      the PMUGRF register for arm64 platform rk3368. On the other hand,
> > the
> > >      PMU/GRF/PMUGRF register file are mapped as "syscon", then referenced
> > >      by other DT nodes by phandle. So maybe let it as a separate DT node
> > > here
> > >      is better.
> >
> > In that case you should probably implement a reboot notifier in each of
> > the drivers you list and depending on the generation of the SoC. You can
> > easily parameterize this by matching on the compatible string.
> >
> > Thierry
> >
> 
>  There is no rockchip specific driver for PMU/GRF/PMUGRF register file I
> list above? they
>  use the generic driver ?syscon?

Well, just go and write specific drivers, then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/2dc1062b/attachment.sig>
