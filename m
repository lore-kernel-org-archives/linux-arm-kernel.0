From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 18:21:01 -0600
Subject: [PATCH v13 3/6] of, numa: Add NUMA of binding implementation.
In-Reply-To: <56D87572.3090002@caviumnetworks.com>
References: <1456959362-2036-1-git-send-email-ddaney.cavm@gmail.com>
 <1456959362-2036-4-git-send-email-ddaney.cavm@gmail.com>
 <CAL_JsqLRP6tmpY7cJ61Ybrrai4ctA7ezyUGmYwdbywe+-qBG5A@mail.gmail.com>
 <56D87572.3090002@caviumnetworks.com>
Message-ID: <CAL_JsqL4FEkP-GhHf0Hyh9spKf=oV+Ft+GFfVFoZmYMyvCoDkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 11:33 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 03/02/2016 07:34 PM, Rob Herring wrote:
>>
>> On Wed, Mar 2, 2016 at 4:55 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>>
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> Add device tree parsing for NUMA topology using device
>>> "numa-node-id" property in distance-map and cpu nodes.
>>>
>>> This is a complete rewrite of a previous patch by:
>>>     Ganapatrao Kulkarni<gkulkarni@caviumnetworks.com>
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>>>   drivers/of/Kconfig   |   3 +
>>>   drivers/of/Makefile  |   1 +
>>>   drivers/of/of_numa.c | 200
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/of.h   |   9 +++
>>>   4 files changed, 213 insertions(+)
>>>   create mode 100644 drivers/of/of_numa.c

[...]

>>> +static int __init of_parse_distance_map(void)
>>> +{
>>> +       int ret = -EINVAL;
>>> +       struct device_node *np = of_find_node_by_name(NULL,
>>> "distance-map");
>>> +
>>> +       if (!np)
>>> +               return ret;
>>> +
>>> +       if (of_device_is_compatible(np, "numa-distance-map-v1")) {
>>
>>
>> You can use of_find_compatible_node() instead of these 2 calls.
>
>
> Well, we need to match exactly the name "distance-map",
> of_find_compatible_node() doesn't match on the name, so I think we need two
> checks, one for name and one for compatible.

Node names generally aren't supposed to matter and the kernel's job is
not to validate DTs, So just finding the compatible should be enough.

Not a big deal, so I've acked v14. If there's a v15, then please make
the change.

Rob
