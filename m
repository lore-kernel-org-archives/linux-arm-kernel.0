From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 14:52:25 -0700
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
Message-ID: <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 11:40 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 July 2014 11:47, Olof Johansson <olof@lixom.net> wrote:
>> Why complicate it by using two properties?
>>
>> If there is no property, then the CPUs are assumed to be controlled
>> independently.
>>
>> if there is a clock-master = <phandle> property, then that points at
>> the cpu that is the main one controlling clock for the group.
>>
>> There's really no need to label the master -- it will be the only one
>> with incoming links but nothing outgoing. And a master without slaves
>> is an independently controlled cpu so you should be fine in that
>> aspect too.
>
> I thought so earlier, but then I remembered something I read long back.
> Don't remember which thread now, but I *might* be wrong..
>
> "Bindings are like APIs and new bindings shouldn't break existing stuff.."
>
> And:
>
>> If there is no property, then the CPUs are assumed to be controlled
>> independently.
>
> seems to break the existing API.

What is the current API that is being broken, in your opinion?

> But if that isn't the case, the bindings are very simple & clear to handle.
> Diff for new bindings:

It's somewhat confusing to see a diff to the patch instead of a new
version. It seems to remove the cpu 0 entry now?


-Olof
