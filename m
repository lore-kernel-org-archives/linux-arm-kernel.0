From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 May 2015 01:02:55 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150513085528.GA6994@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
Message-ID: <555D750F.80304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 03:55 AM, Viresh Kumar wrote:
[...]
>> It seems wrong to me that the clock and supply data is owned by the cpu
>> node, and not the opp descriptor. Everything about the opp transition
>> should belong to a provider node. Then the cpu simply needs to consume
>> that via a phandle.
> 
> https://lists.linaro.org/pipermail/linaro-kernel/2014-December/019505.html

This argues that clock is an input to the cpu, this is not in-correct,
but, it could also be argued that OPP tables are clock dependent.

For example, with multiple clock source options that a device might
choose to select from internally(by some means.. lets not just restrict
ourselves to just CPUs here for a moment), the tables might be
different. We can always debate that this then is the responsibility of
the driver handling the description for that device and we might want
possibility of vice versa as well - same OPP table used by different
clock source selections as well.

-- 
Regards,
Nishanth Menon
