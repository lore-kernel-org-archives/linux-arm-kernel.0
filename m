From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 27 Feb 2017 19:58:28 +0900
Subject: Recommended notation for OPP to avoid DTC warnings
In-Reply-To: <20170227105533.GA19417@vireshk-i7>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
 <20170227104445.GE6795@leverpostej> <20170227105533.GA19417@vireshk-i7>
Message-ID: <CAK7LNARnxdi4B2G2FnvfQNM8iVK+rsdH7N7Uwd+Qc2d9hSsuUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-27 19:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 27-02-17, 10:44, Mark Rutland wrote:
>> On Sun, Feb 26, 2017 at 02:18:03PM +0900, Masahiro Yamada wrote:
>> > Hi.
>> >
>> >
>> > Decumentation/devicetree/bindings/opp/opp.txt
>> > takes examples like this:
>> >
>> >         opp at 1000000000 {
>> >                 opp-hz = /bits/ 64 <1000000000>;
>> >                 opp-microvolt = <970000 975000 985000>;
>> >                 opp-microamp = <70000>;
>> >                 clock-latency-ns = <300000>;
>> >                 opp-suspend;
>> >         };
>>
>> > If we follow this notation and the device-tree is built with W=1,
>> > DTC warns like follows:
>> >
>> > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
>> > unit name, but no reg property
>> >
>> > Is there a recommended notation to avoid it?
>> >
>> > Maybe, simply omit the "@" ?
>>
>> I think just s/@/-/ should be fine, e.g. call the above opp-1000000000.
>
> That's fine with me. I can send a patch to fix all existing users if we all
> agree for it.


OK with me.

Also, please remember to update the examples
in Documentation/devicetree/bindings/opp/opp.txt





-- 
Best Regards
Masahiro Yamada
