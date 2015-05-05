From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 5 May 2015 16:18:59 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150504121209.GM15510@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
Message-ID: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:
>
>> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
>> +  regulators.
>> +
>> +  A single regulator's current is specified with an array of size one or three.
>> +  Single entry is for target current and three entries are for <target min max>
>> +  currents.
>
> What is this for - are you trying to define OPPs for current regulators?
> If you are that's worrying, I can't think of a sensible use case.  If
> that's not what's happening then the binding needs to be more specific
> about what this is supposed to mean.

Its another property of the same voltage regulator we are using in
opp-microvolt.
I hope that makes sense ?

And that's why I wrote this as well:

+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node. If few regulators don't provide
+  capability to configure current, then values for then should be marked as
+  zero.

i.e. this is optional but the voltage regulator isn't..

But, perhaps I need to write it with more clarity? Or this field doesn't make
sense ?

FWIW, its an outcome of this request from Stephen:

https://www.marc.info/?l=linux-arm-kernel&m=142370250522589&w=3
