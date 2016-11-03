From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Nov 2016 07:44:55 +0530
Subject: [PATCH v3 2/3] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <9a185460-a241-4876-2915-6975c57527ca@ti.com>
References: <20161027214131.1725-1-d-gerlach@ti.com>
 <20161027214131.1725-3-d-gerlach@ti.com>
 <20161102035941.GA10786@vireshk-i7>
 <9a185460-a241-4876-2915-6975c57527ca@ti.com>
Message-ID: <20161103021455.GE10786@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-11-16, 11:03, Dave Gerlach wrote:
> >>+cpu0_opp_table: opp_table0 {
> >>+	compatible = "operating-points-v2-ti-am3352-cpu";
> >>+	ti,syscon-efuse = <&scm_conf 0x7fc 0x1fff 0>;
> >>+	ti,syscon-rev = <&scm_conf 0x600>;
> >>+
> >>+	/*
> >>+	 * The three following nodes are marked with opp-suspend
> >>+	 * because they can not be enabled simultaneously on a
> >>+	 * single SoC.
> >>+	 */

I missed reading this comment :(

>>+	opp50 at 300000000 {
> >>+		opp-hz = /bits/ 64 <300000000>;
> >>+		opp-microvolt = <950000 931000 969000>;
> >>+		opp-supported-hw = <0x06 0x0010>;
> >>+		opp-suspend;
> >>+	};
> >>+
> >>+	opp100 at 275000000 {
> >>+		opp-hz = /bits/ 64 <275000000>;
> >>+		opp-microvolt = <1100000 1078000 1122000>;
> >>+		opp-supported-hw = <0x01 0x00FF>;
> >>+		opp-suspend;
> >>+	};
> >>+
> >>+	opp100 at 300000000 {
> >>+		opp-hz = /bits/ 64 <300000000>;
> >>+		opp-microvolt = <1100000 1078000 1122000>;
> >>+		opp-supported-hw = <0x06 0x0020>;
> >>+		opp-suspend;
> >
> >Only one OPP in the table can be marked as suspend OPP.
> >
> 
> Does that still apply when opp-supported-hw is involved? Based on the
> comment at the start of the table, those OPPs are all mutually exclusive and
> will not ever be enabled on the same piece of silicon, they represent the
> lowest OPP for each of three different supported-hw configurations.

You are right, its fine.

-- 
viresh
