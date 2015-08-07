From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 07 Aug 2015 10:45:22 +0100
Subject: [PATCH v4 1/6] ARM: shmobile: r8a7740 dtsi: Add L2
 cache-controller node
In-Reply-To: <CAMuHMdVAOba0ofmoy8OH2DdY1m3XaD8iOXvXBE035=C4yK58VQ@mail.gmail.com>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>	<1438765090-823-2-git-send-email-geert+renesas@glider.be>	<55C1D894.8070302@arm.com>	<CAMuHMdXdEV+41mH338bDbazzqOErDLQkBUAj2+uVX4Wupn1ABQ@mail.gmail.com>	<55C1EC3C.9000407@arm.com>
 <CAMuHMdVAOba0ofmoy8OH2DdY1m3XaD8iOXvXBE035=C4yK58VQ@mail.gmail.com>
Message-ID: <55C47E32.6070400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/15 17:21, Geert Uytterhoeven wrote:
> Hi Sudeep,
>
> On Wed, Aug 5, 2015 at 12:58 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 05/08/15 11:44, Geert Uytterhoeven wrote:
>>> On Wed, Aug 5, 2015 at 11:34 AM, Sudeep Holla <sudeep.holla@arm.com>
>>> wrote:

[..]

>>>>
>>>> Any particular reason whey you need all this cache-* properties ? Is
>>>
>>> To describe the cache as good as possible.
>>
>> Why if you can probe it ? IMO DT is mostly useful to describe things
>> that can't be probed/discovered using hardware.
>>
>>>> something broken on these SoCs ? We should be able to get most of these
>>>> information from the SoC(reading some registers). It's good to avoid
>>>> passing them via DT if they can be discovered from hardware.
>>>
>>> So we have all these documented properties in
>>> Documentation/devicetree/bindings/arm/l2cc.txt, but they're not meant to
>>> be used?
>>
>> No I didn't mean that, I just wanted to know if they can't be probed due
>> to some hardware issue. It would avoid issues with wrong DTs especially
>> if they are not so easy to upgrade.
>
> I think it works just fine without them.
>

Yes, in general if you specify a value in DT that can be probed, its
usually to override the probed value(useful if there is some h/w errata)...

> Should I drop all cache-* properties marked optional in
> Documentation/devicetree/bindings/arm/l2cc.txt?
> That would be cache-size, cache-sets, cache-block-size, and cache-line-size.
>

... however if you incorrect values by mistake, then it's problematic
even if h/w provides correct value.


> What about the L1 cache? I know Linux uses none of the d-cache-*
> and i-cache-* properties.
>

Same there, IIRC PPC use them, but on ARM I think so far the need has
not arise.

Just to re-iterate myself, I am not against adding them, but it's not
really needed. I just wanted to know if there was any h/w issue.

Regards,
Sudeep
