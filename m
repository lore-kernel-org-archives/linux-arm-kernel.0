From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 3 Dec 2015 10:11:28 +0000
Subject: [RFC] rk3368 idle states
In-Reply-To: <2472961.2QZIyIIJQ0@diego>
References: <20151202111858.GB18981@red-moon>
 <2472961.2QZIyIIJQ0@diego>
Message-ID: <20151203101128.GB2110@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thu, Dec 03, 2015 at 02:05:01AM +0100, Heiko St?bner wrote:
> Hi Lorenzo,
> 
> Am Mittwoch, 2. Dezember 2015, 11:18:58 schrieb Lorenzo Pieralisi:
> > while reviewing other dts idle states bindings I spotted the following
> > snippet in arch/arm64/boot/dts/rockchip/rk3368.dtsi:
> > 
> > cpu_sleep: cpu-sleep-0 {
> >        compatible = "arm,idle-state";
> >        arm,psci-suspend-param = <0x1010000>;
> >        entry-latency-us = <0x3fffffff>;
> >        exit-latency-us = <0x40000000>;
> >        min-residency-us = <0xffffffff>;
> > };
> > 
> > Could you please explain to me how you obtained these residency/latency
> > values ? They make NO sense whatsoever and I am quite tempted to
> > ask you to remove this data from the dts file, it is just wrong.
> 
> I took these values verbatim from the vendor kernel when adding the core 
> rk3368 support.
> 
> I guess I was overly enthusiastic, that psci worked out of the box for smp, 
> that I didn't check the latency/residency values enough at that time. As time-
> values they are really overly long :-) .
> 
> 
> Nevertheless I have inquired now, what the background of those values is.

Thank you, they must be updated, hopefully they won't unearth any issue
with the idle state - ie at present the idle state simply turns out unused.

Lorenzo
