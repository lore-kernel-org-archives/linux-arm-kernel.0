From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jan 2015 07:09:23 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150128200600.GR21293@sirena.org.uk>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <20150128200600.GR21293@sirena.org.uk>
Message-ID: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 01:36, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 23, 2015 at 04:14:50PM +0530, Viresh Kumar wrote:
>
>> +- opp-listN:
>> +  List of nodes defining performance points. Following belong to the nodes
>> +  within the opp-lists.
>
> Why is there the N here?  It doesn't correspond to the examples...

I meant [0..N], probably its better to remove it ..

>> +  Required properties:
>> +  - opp-khz: Frequency in kHz
>> +  - opp-microvolt: voltage in micro Volts
>
> I thought the goal here was to specify ranges?

Yeah, I wasn't 100% sure of what you suggested and so asked a question in
the mail earlier. I will change it to what you suggested.

>> +- oppN:
>> +  Operating performance point node per device. Devices using it should have its
>> +  phandle in their "operating-points-v2" property.
>> +
>> +  Required properties:
>> +  - compatible: allow OPPs to express their compatibility.
>> +  - opp-list: phandle to opp-list defined above.
>
> I don't understand what that compatible property is intended to mean and
> I expect other readers might be similarly confused - is it a standard
> compatbile property meaning this noe corresponds to some sort of device?

The goal is to choose the driver which we want to probe for a platform. There
can be multiple DT enabled cpufreq drivers present in a build and the platform
needs some way to choose one of them.

For example, if both cpufreq-dt, exynos-cpufreq and arm-big-little drivers are
present in a kernel build, the how do we specify which one a platform wants to
use.

The generic drivers (cpufreq-dt and big LITTLE) should match with some generic
strings, as these aren't specific to any platform. But exynos one can be matched
with the machine or Soc-family's existing compatible names.

> There also appears to be no code matching these bindings...

I still have to post it, was trying to finalize the bindings first.
