From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 05 Aug 2010 08:12:04 -0700
Subject: [linux-pm] [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
In-Reply-To: <AANLkTimUeFf_Z5pi3x7PWNb0YpooxPb3aN1cmtv1XjQx@mail.gmail.com>
	(Magnus Damm's message of "Thu, 5 Aug 2010 12:07:53 +0900")
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
	<34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
	<AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
	<87k4o7r7sv.fsf@deeprootsystems.com>
	<AANLkTi=RTigcf-p=GFncAQ2ZjP=4qjDPXjnMmTO_u6tL@mail.gmail.com>
	<AANLkTintoVDFHxmbuj_YHj5e4PzK7j6-SzdWqFKDLjkE@mail.gmail.com>
	<AANLkTimUeFf_Z5pi3x7PWNb0YpooxPb3aN1cmtv1XjQx@mail.gmail.com>
Message-ID: <8739ut2iwr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus Damm <magnus.damm@gmail.com> writes:

> On Thu, Aug 5, 2010 at 8:10 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Tue, Aug 3, 2010 at 9:56 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> On Wed, Aug 4, 2010 at 1:16 AM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> 2) custom vs. platform bus.
>>>>
>>>> The other issue under discussion between Grant & myself[1] has been the
>>>> use of a custom bus instead of the platform bus. ?Following your lead,
>>>> (and preferring that option) I continued to use the platform_bus since
>>>> I only need to override a few of the dev_pm_ops functions.
>>>>
>>>> However, Grant is not happy about overriding the platform_bus. ?He would
>>>> rather see each platform create a custom bus with it's own PM methods.
>>>>
>>>> In this thread[1], I did a quick and dirty proof of concept to show that
>>>> it is possible, but quite frankly, I still much prefer continuing to use
>>>> the platform_bus since it is mostly identical.
>>>>
>>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018925.html
>>>
>>> Thanks for the pointer. I've been thinking of using a custom bus as
>>> well, but from my point of view it's always looked like a lot of
>>> coding without any clear benefit. I understand the idea of wanting to
>>> use a single binary on a wide range of systems, and solving that seems
>>> like a good plan.
>>>
>>> I'm not sure if a custom bus is the best idea. I wouldn't mind being
>>> able to create platform bus instances though.
>>
>> The only problem with multiple platform_bus instances would be that
>> drivers intended to work on both would need to be registered twice;
>> once on the regular platform bus, and once on the custom bus. ?All the
>> rest of the code would be shared, but it probably still doesn't
>> reflect the model that you're shooting for.
>
> Do they really have to be registered twice? With the current driver
> model yes, but perhaps it's possible to adjust the platform bus to
> allow device<->driver matching across buses somehow. I would prefer to
> register drivers only once.

I would too.  My primary objection to the custom bus approach is because
I don't want drivers to have to care what bus (or SoC) they are
connected to.

Kevin
