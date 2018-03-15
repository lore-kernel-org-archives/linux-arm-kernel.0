From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 15 Mar 2018 09:46:45 -0600
Subject: coresight dummy funnel question
In-Reply-To: <CAHrpEqQ8OHKB3gbE6tB0hg-Hz9SCU+wCWsk7QgRwcembvH9aFQ@mail.gmail.com>
References: <CAHrpEqRwwMRUBGa_BYasiondhQALZtMcZC8tUfUYyuQMN47uoQ@mail.gmail.com>
 <CANLsYkzdGSbSSXsCDGUzbYNKHKy7YiWft5JdT5b3RN+aqn+nGQ@mail.gmail.com>
 <CAHrpEqQ8OHKB3gbE6tB0hg-Hz9SCU+wCWsk7QgRwcembvH9aFQ@mail.gmail.com>
Message-ID: <CANLsYkxsratEdiQaRO14hNrzWoQ1LKfWWjjieeeDJ6y=mnGedQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 March 2018 at 15:07, Zhi Li <lznuaa@gmail.com> wrote:
> On Fri, Mar 9, 2018 at 12:03 PM, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>> Hi Zhi,
>>
>> On 7 March 2018 at 08:57, Zhi Li <lznuaa@gmail.com> wrote:
>>> Mathieu:
>>>
>>>            I am working one enable coresight in our SOC.
>>>
>>>            But our SOC's cluster funnel have not export program interface.
>>>            Our cluster included 4 A53.
>>>
>>>            4 ETM of A53 connect to funnel, which have NOT program
>>> interface. Funnel is default enabled.
>>>
>>>            Do you have suggest how to bypass or use dummy funnel in dts file?
>>
>> Is the funnel discoverable on the AMBA bus or is it like the original
>> version of replicators?
>
> No, No any program interface at all. Look like replicators

The best way to proceed is probably to allow entry in the funnel
driver from the platform bus as well.  There is a very good example
here [1].

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v4.16-rc5/source/drivers/tty/serial/amba-pl011.c

>
> best regards
> Frank Li
>
>>
>>>
>>>
>>> best regards
>>> Frank Li
