From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Mon, 24 Apr 2017 11:43:52 +0100
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <b8cf7acd-83e9-49fb-0800-19a76b8dcce5@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <db45d0d68957d699f13a0d92f4f84d8ebfd0270e.1491118230.git.guillaume.tucker@collabora.com>
 <20170404020056.d7osj7rmog22xbjd@rob-hp-laptop>
 <b8cf7acd-83e9-49fb-0800-19a76b8dcce5@collabora.com>
Message-ID: <32edad9f-a568-c67d-060d-055517d6782f@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/17 10:15, Guillaume Tucker wrote:
> Hi Rob,
>
> On 04/04/17 03:00, Rob Herring wrote:
>> On Sun, Apr 02, 2017 at 08:59:44AM +0100, Guillaume Tucker wrote:

>>> +- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
>>> +  for details.
>>
>> Is this going to be sufficient vs. operating-points-v2? Or should it be
>> a power domain with OPPs?
>
> In principle, switching to operating-points-v2 should be very
> straightforward.  I have smoke-tested the driver with an
> operating-points-v2 table and a phandle to it inside the gpu node
> in place of operating-points and it seems to be working fine.  At
> least it parsed the OPPs and got initialised correctly.
>
> My understanding is that operating-points (v1) are not deprecated
> so we could keep the bindings as-is, but please let me know
> otherwise and I can try to address that in my next patch version.
> In the documentation, it should only be the case of replacing
> operating-points with operating-points-v2.

While the opp bindings documentation doesn't mention anything
about operating-points being deprecated, the code and comments in
of.c are pretty clear about this:

	/*
	 * OPPs have two version of bindings now. The older one is deprecated,
	 * try for the new binding first.
	 */

So I shall use operating-points-v2 in my patch v4.

Thanks,
Guillaume
