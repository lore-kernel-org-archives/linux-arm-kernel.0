From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 18 Mar 2015 09:32:53 +0530
Subject: [RFC PATCH v4 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <CAFpQJXVc5c=YRLw3uS5RiSR13veo_SUiM-aV6hf+diQuWxdfYQ@mail.gmail.com>
References: <1421924755-26029-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1421924755-26029-4-git-send-email-gkulkarni@caviumnetworks.com>
 <2882934.brFyhkGPyE@wuerfel> <1885509.Z0Gm3e3FlX@wuerfel>
 <CAFpQJXUvux+b9hYx_ZY-1hor0HRFFgh=e4vCYyJiDHrDC9Y=tQ@mail.gmail.com>
 <CAFpQJXXkXatxRcfpA1DjuuiUf3vup3DV+dACyGxT=TDkrO8rNQ@mail.gmail.com>
 <CAFpQJXVc5c=YRLw3uS5RiSR13veo_SUiM-aV6hf+diQuWxdfYQ@mail.gmail.com>
Message-ID: <CAFpQJXWL-NM+WndfB5pLj6TmdVngACR9YCr_ahaUTqAO3DaX1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will, Mark, Arnd

On Tue, Mar 10, 2015 at 2:12 PM, Ganapatrao Kulkarni
<gpkulkarni@gmail.com> wrote:
> Ping?
>
> On Tue, Feb 24, 2015 at 2:22 PM, Ganapatrao Kulkarni
> <gpkulkarni@gmail.com> wrote:
>> Hi Arnd,
>>
>> On Fri, Jan 23, 2015 at 6:07 PM, Ganapatrao Kulkarni
>> <gpkulkarni@gmail.com> wrote:
>>> Hi Arnd,
>>>
>>> On Thu, Jan 22, 2015 at 11:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Thursday 22 January 2015 17:47:13 Arnd Bergmann wrote:
>>>>>
>>>>> This seems wrong still: The clusters and cores do not have unique
>>>>> numbers. I believe the code will not work correctly, and it won't
>>>>> be compliant with the binding from patch 2.
>>>>>
>>>>> I think the right way here would be to use
>>>>>
>>>>>         arm,associativity = <0 2 47>;
>>>>>
>>>>> for cpu at 20f, and
>>>>>
>>>>>         arm,associativity = <1 3 48>;
>>>>>
>>>>> for cpu at 10000. Your previous version used the numbers from
>>>>> the reg property, which should be fine as well if that helps:
>>>>>
>>>>>
>>>>>         arm,associativity = <0x0 0x200 0x20f>;
>>>>>
>>>>>         arm,associativity = <0x10000 0x10000 0x10000>;
>>>>>
>>>>> which should have the same effect as above, as long as the code
>>>>> can handle the numbers not being consecutive.
>>>>>
>>>>>
>>>>
>>>> Upon further consideration, I think your patch is correct after
>>>> all, but let me check again on PowerPC machines.
>>> i have removed, board id which was in previous patch, to keep the
>>> associativity aligned to mpidr, ie. socket,cluster id and core id.
>>> both previous and current mappings holds good for our design.
>>> our topology is 2 sockets(aff2=0and 1) , each having 3
>>> clusters(aff1=0to2)and each cluster having 16 cores(aff0:0to15)
>>> in associativity property, for our case, only first id(socket id) is
>>> mapped to numa, others are mentioned only to describe the topology.
>>>>
>>>>         Arnd
>> any further comments, how we go about these patches?
>> please suggest.
>>
>>> thanks
>>> Ganapat
>>
>> thanks
>> Ganapat

Please suggest how we go about these patches.
please share your review comments, if any changes needs to be done.


thanks
Ganapat
