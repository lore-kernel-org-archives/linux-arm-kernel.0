From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 May 2015 10:43:35 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150515141525.GK6348@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk> <20150514003201.20636.83883@quantum>
 <CAKohpokeKtcJdrBcPZBBPR2zfJgpvuM_=wRaX5q1Uto2qx1oHQ@mail.gmail.com>
 <20150515141525.GK6348@linux>
Message-ID: <55561427.4030207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2015 09:15 AM, Viresh Kumar wrote:
> On 14-05-15, 03:25, Michael Turquette wrote:
>> No, we don't understand the problem space well enough to form an ABI.
> 
> And why do you think so? We have been facing many problems since a
> long time which we are trying to solve here.

I would state "problem space is better defined now based on data made
public by developers on various SoCs", this new binding seems to
address majority of the concerns (esp with vendor specific
extensions). OPP behavior is very SoC vendor specific -> it can only
evolve with an extensible framework - which is what this new binding
provides. This is something that was badly missing in the older
binding and framework (I should blame myself for it), even though the
previous definitions were simple, in effect it was inflexible to the
detriment of many SoCs.

Do we know 100% if the new binding solves every SoC's issues - we wont
be able to do that unless folks speak up - but then, providing ability
for vendor specific extension allows to consolidate and make common as
necessary.

Point blank rejection might be a bit of an overkill, IMHO.

> 
> I agree that it might not be right to try too many things which may
> not be required later, but most of the things we have now in new
> bindings are actually required.
> 
>> Putting this stuff in C without any philosophical constraints on whether
>> or not we can change it later is the way to go.
> 
> I don't agree to that :)
> 
I second Viresh on this. Benefit of forcing data separation into
device tree has provided the flexibility now to be able to loadup OPPs
from bootloader OR over DTC overlay as desired - that is the right
choice rather than embedding it within C code, providing kludgy
extension options to provide dynamic data updates.

-- 
Regards,
Nishanth Menon
