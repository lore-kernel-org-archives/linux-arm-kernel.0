From: fkan@apm.com (Feng Kan)
Date: Wed, 25 Sep 2013 08:58:40 -0700
Subject: General placement of platform drivers and header files
In-Reply-To: <CAOesGMj9qUKw9hTSmoV76bvbKHbapxyUss4JfrD0pg9=oPpLdg@mail.gmail.com>
References: <CAL85gmAi9qZWdeHt5JWeEW-OuNKdxqt-0fPDeCugnpun_6BDKA@mail.gmail.com>
 <CAOesGMj9qUKw9hTSmoV76bvbKHbapxyUss4JfrD0pg9=oPpLdg@mail.gmail.com>
Message-ID: <CAL85gmA2V=vcPV3wP_LsU4V0_YSWUqHR_8qzfYJeZVg3PoCMQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 9:37 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, Sep 24, 2013 at 8:33 PM, Feng Kan <fkan@apm.com> wrote:
>> Hi all:
>>
>> I have some drivers like Queue Manager and co-processor driver that
>> are used by other
>> drivers like Ethernet. Would it be appropriate to locate these drivers
>> under one folder under
>> drivers/misc/arch_name/xxx.
>
> drivers/misc is almost always the wrong answer to where to add a driver.
>
> It would help to also know how the devices interact to answer the
> question of best location. Are the drivers for the coprocessor and for
> the queue manager mostly a pass-through for some operations (and some
> shared allocation of resources), i.e. more of a library, or is it a
> full-fledged driver that will service interrupts, etc?

Lets take QM for an example, the driver is used to allocate queues for
the Ethernet driver and there are ISRs for QM to take care of
errors and change in status.

>
>> My other question is on common header files (belonging to Queue
>> Manager) but is sourced
>> by Ethernet, where should those reside. Should they go under
>> linux/include/misc/arch_name
>> or directly sourced using the ../../../misc/arch_name/headerfile method.
>
> This depends somewhat on where the driver ends up, but somewhere under
> include/linux is likely the right place for the in-kernel interface
> header files.

Given the above, how should the header file be handled?

>
>
> -Olof
