From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 10:27:30 +0930
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
Message-ID: <1531702650.981120.1441646240.2E63DD09@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

I've rearranged your reply slightly :)

On Sat, 14 Jul 2018, at 00:44, Alexander Amelkin wrote:

> 
> So I'm writing this to support your position in this discussion and to
> let Rob and other reviewers know that this feature is actually needed.

Thanks.

So to summarise some other replies so far, YADRO (Alexander) and Dell (Eugene) - platform vendors integrating BMCs - are interested in a solution, and the patches are seen useful for ASPEED and Nuvoton (Avi) BMCs.

> 
> From the discussion it looks to me like Rob is not familiar with
> specifics of BMC-managed servers and tries to apply to them the rules
> that have proven to be good for workstations and laptops.
> 

Whatever Rob's familiarity with BMCs or other systems, I'm keen to listen to, explore and gain from his experience. I was certainly expecting push back on these patches and in different circumstances I'd probably say no to them as well. The argument for them needs to stand up to scrutiny, and if that scrutiny leads to alternative solutions (that, ideally, are not /dev/mem) then that's fine.

Currently I think we need what I've proposed despite it looking like a violation of abstractions, because the hardware itself doesn't have a neat, abstract design. But we could be thinking about it wrong, e.g. maybe what we need instead are no devicetree bindings and simply some in-kernel helpers that allow arbitrary drivers to instantiate the sysfs interface I've proposed for these fields under their control. That removes the need for explicit description in the devicetree, though may lead to the creation of a number of unique drivers (and bindings) that each cover only the functions we're trying to generalise over here.

It would be good to have some feedback on the proposed sysfs interface as well - as explored above we could feasibly live without the bindings in their current form but taking away the sysfs interface would nuke the series.

Cheers,

Andrew
