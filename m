From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Fri, 6 Jul 2018 15:20:13 -0400
Subject: [PATCH v7 00/10] Introduce the Counter subsystem
In-Reply-To: <59b0950e-ef39-4ad4-a32b-316992e1f236@lechnology.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
 <20180703024835.GA9493@sophia> <20180706182154.0000002d@huawei.com>
 <59b0950e-ef39-4ad4-a32b-316992e1f236@lechnology.com>
Message-ID: <20180706192013.GA6810@sophia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 01:22:57PM -0500, David Lechner wrote:
>On 07/06/2018 12:21 PM, Jonathan Cameron wrote:
>> On Mon, 2 Jul 2018 22:48:35 -0400
>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>> Is frequency useful for other
>>> applications on its own (perhaps velocity of an automobile device
>>> equipped with an encoder wheel for some reason or other)?
>
>Since we are just dealing with counters here, I think we should call
>it "rate" instead of "frequency". At least that seems to be the common
>name in industrial automation.
>
>Another possible use case for "rate" would be flow meters. Some
>flow meters generate a pulse every X gallons. Assuming that the
>counter also has a rate output, then you can scale the rate (e.g.
>counts/second) into flow in gallons per minute.
>
>>>
>>> Once we figure out how this data is used, we can determine the best
>>> design and place to introduce it into the Generic Counter interface,
>>> then move on to integration from there.
>> 
>> Great - as long as this fits reasonably well in ABI wise (whatever the
>> details) sounds like we don't need to solve it today.  I'm anxious not
>> to delay merging this counter subsystem for another cycle.
>
>Certainly don't delay things on account of me. I'm just trying to get
>a feel for where things are headed since I missed the earlier discussions.
>I don't see any major problems with the current state of things.
>
>Once this lands, I may have a go at the eQEP and see how it looks.

No worries, it looks like your application would be served well by the
Generic Counter interface, and exposing a "rate" value would be a simple
feature to add. However, since this patchset has been stabilizing over
the past few revisions, I want to postpone the addition of new features
until this interface and its current feature set is merged.

David, once this introduction patchset has been merged, submit to me a
patch adding the "rate" functionality feature and we'll continue
discussing it there.

William Breathitt Gray
