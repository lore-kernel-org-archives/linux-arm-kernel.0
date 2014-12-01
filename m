From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 01 Dec 2014 13:35:25 +0000
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>	<7885354.QleDlR7NUO@wuerfel>
 <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
Message-ID: <547C6E9D.2090205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/12/14 13:29, Viresh Kumar wrote:
> On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
>> Thanks a lot for working on this, we really need to figure it out one day!
>
> :)
>
>> Your patches seem well-implemented, so if everybody thinks the general
>> approach is the best solution, we should do that. From my point of view,
>> there are two things I would do differently:
>>
>> - In the DT binding, I would strongly prefer anything but the root compatible
>>    property as the key for the new platforms. Clearly we have to keep using
>>    it for the backwards-compatibility case, as you do, but I think there
>>    are more appropriate places to put it. Sorting from most favorite to least
>>    favorite, my list would be:
>>          1. a new property in /cpus/
>>          2. a new property each /cpus/cpu at ... node.
>
> I did it this way earlier and named it dvfs-method but probably putting this
> into the /cpus/ node is far better. But then Sudeep asked to utilize
> compatible property only..
>
> Are you fine with the name here? "dvfs-method"
>

That's right, I don't like driver specific method in the cpu node as you
initially did. But if it's a property in the chosen node (where we
usually put the Linux specific properties), I am fine with
that as Arnd has illustrated in his patch.

Regards,
Sudeep
