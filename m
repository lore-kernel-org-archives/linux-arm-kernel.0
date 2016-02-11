From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 11 Feb 2016 21:28:01 +0530
Subject: [PATCH v10 3/8] dt, numa: adding numa dt binding implementation.
In-Reply-To: <20160211153255.GR24726@rric.localdomain>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
 <CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
 <20160211153255.GR24726@rric.localdomain>
Message-ID: <CAFpQJXU+fon8DY--qhyZV=JDv9omqs=c9eSX34g1J2w2uudNKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Feb 11, 2016 at 9:02 PM, Robert Richter
<robert.richter@caviumnetworks.com> wrote:
> On 11.02.16 08:50:41, Rob Herring wrote:
>> On Tue, Feb 2, 2016 at 4:09 AM, Ganapatrao Kulkarni
>> <gkulkarni@caviumnetworks.com> wrote:
>> > dt node parsing for numa topology is done using device property
>> > numa-node-id and device node distance-map.
>>
>> How is it that powerpc doesn't need flat DT parsing for NUMA? Both
>> arches are memblock based and the binding is similar IIRC, so you
>> should be able to find a way to do this with the unflattened tree.
>> Ideally, there should be some common code shared as well.

powerpc has implemented numa binding using property named
"ibm,associativity", we too started adding using the same binding[
refer version V6]
however had discussion/review with Mark R about mapping and we could not map to
some of the topology like mesh and ring topology.

So we have defined and implemented this new binding which is simple
and scalable.
This binding is very much aligned to ACPI NUMA specification.

>>
>> Do you have a git tree with this series?
>
> I have pushed it here for you:
>
>  https://git.kernel.org/cgit/linux/kernel/git/rric/linux.git/log/?h=thunder/numa-v10

thanks Robert.
>
> -Robert

thanks
Ganapat
