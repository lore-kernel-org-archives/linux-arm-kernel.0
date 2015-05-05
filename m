From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 5 May 2015 17:13:33 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150505105714.GA22845@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
Message-ID: <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 16:27, Mark Brown <broonie@kernel.org> wrote:
> No, it doesn't - you're not answering the question about what this is
> for.

I don't know how this information will be used finally. Probably the
platform driver will do the configuration based on the volt-cur pair.

> To know if this makes sense I need to know what you beleive "setting the
> current" does.  If you literally mean setting the current it makes no
> sense at all.  If you mean something else that something else should
> probably be written into the binding.

Yeah, that was a wrong statement. We can't configure current separately.

Does this diff make it any better ?


diff --git a/Documentation/devicetree/bindings/power/opp.txt
b/Documentation/devicetree/bindings/power/opp.txt
index c96dc77121b7..a57e88ab4554 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -59,16 +59,18 @@ properties.
   regulators are specified in device's DT node.

 - opp-microamp: current in micro Amperes. It can contain entries for multiple
-  regulators.
+  regulators. This can be referenced (along with voltage and freqency) while
+  programming the regulator.

   A single regulator's current is specified with an array of size one or three.
   Single entry is for target current and three entries are for <target min max>
   currents.

   Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node. If few regulators don't provide
-  capability to configure current, then values for then should be marked as
-  zero.
+  regulators are specified in device's DT node. If current value for few
+  regulators isn't required to be passed, then values for such
regulators should
+  be marked as zero. If it isn't required for any regulator, then this property
+  need not be present.

 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.


(Restoring my laptop after a corrupted disk, and so sending it from gmail,
might be a bit corrupted)..
