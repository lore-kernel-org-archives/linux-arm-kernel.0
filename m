From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Jun 2015 08:24:25 +0530
Subject: [PATCH V7 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <CAKohpomTT6i0dbboK901eguCbQiBdCT6gvLvTY24ajDdY__2fg@mail.gmail.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <dedf8c02fdd9dbf169f43de74ead4c1434d89b45.1433434659.git.viresh.kumar@linaro.org>
 <CAL_JsqJb4P2Z2esgm5ffjWV37MU2KUF4gBdUpwSV8+21iTD1Bg@mail.gmail.com>
 <CAKohpomTT6i0dbboK901eguCbQiBdCT6gvLvTY24ajDdY__2fg@mail.gmail.com>
Message-ID: <20150616025425.GB26592@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-06-15, 06:01, Viresh Kumar wrote:
> On 16 June 2015 at 05:05, Rob Herring <robherring2@gmail.com> wrote:
> >> +- opp-suspend: Phandle of the OPP to set while device is suspended.
> >> +
> >
> > I would just do a bool property in the OPP you want.
> 
> I will do that if you want, no big deal.

In order to not waste any time, here is the change you suggested. Ack
the one (original change or this one) you like :)

------------------8<----------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2015 08:27:49 +0530
Subject: [PATCH V8] OPP: Add binding for 'opp-suspend'

On few platforms, for power efficiency, we want the device to be
configured for a specific OPP while we put the device in suspend state.

Add an optional property in operating-points-v2 bindings for that.

Acked-by: Nishanth Menon <nm@ti.com>
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V7->V8:
- opp-suspend is moved to OPPs instead of the table, and is bool now.

 Documentation/devicetree/bindings/power/opp.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 2938c52dbf84..2d4291127003 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -113,6 +113,9 @@ properties.
   frequency for a short duration of time limited by the device's power, current
   and thermal limits.
 
+- opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
+  the table should have this.
+
 - status: Marks the node enabled/disabled.
 
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
@@ -152,6 +155,7 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
+			opp-suspend;
 		};
 		opp01 {
 			opp-hz = <1100000000>;
@@ -230,6 +234,7 @@ independently.
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
+			opp-suspend;
 		};
 		opp01 {
 			opp-hz = <1100000000>;
@@ -305,6 +310,7 @@ DVFS state together.
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
+			opp-suspend;
 		};
 		opp01 {
 			opp-hz = <1100000000>;
@@ -330,6 +336,7 @@ DVFS state together.
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
+			opp-suspend;
 		};
 		opp11 {
 			opp-hz = <1400000000>;
-- 
2.4.0
