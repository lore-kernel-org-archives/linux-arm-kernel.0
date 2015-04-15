From: ahs3@redhat.com (Al Stone)
Date: Wed, 15 Apr 2015 10:29:33 -0600
Subject: [RFC PATCH 5/5] arm64: qcom: add cpu operations
In-Reply-To: <20150415145350.GB22741@localhost>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-6-git-send-email-galak@codeaurora.org>
 <20150414162953.GL28709@leverpostej> <552D9A37.6070107@redhat.com>
 <20150415090425.GA2866@leverpostej> <20150415145350.GB22741@localhost>
Message-ID: <552E91ED.2080805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 08:53 AM, Catalin Marinas wrote:
> On Wed, Apr 15, 2015 at 10:04:25AM +0100, Mark Rutland wrote:
>> On Tue, Apr 14, 2015 at 11:52:39PM +0100, Al Stone wrote:
>>> On 04/14/2015 10:29 AM, Mark Rutland wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>>>>> index 8b9e0a9..35cabe5 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>>>>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>>>>> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
>>>>>                           be one of:
>>>>>                              "psci"
>>>>>                              "spin-table"
>>>>
>>>> In the case of these two, there's documentation on what the OS, FW, and
>>>> HW are expected to do. There's a PSCI spec, and spin-table is documented
>>>> in booting.txt (which is admittedly not fantastic).
>>>> [snip...]
>>>
>>> Perhaps a side topic, but I thought spin-table was being actively discouraged
>>> for arm64.  Forgive me if I missed the memo, but is that not correct?
>>
>> We prefer that people implement PSCI, and if they must use spin-table,
>> each CPU has its own release address.
>>
>> However, we don't want implementation-specific mechanisms, and
>> spin-table is preferable to these.
> 
> An important aspect is that with spin-table you don't get CPU off or
> suspend and some kernel functionality will be missing (kexec being one
> of them).
> 

Thanks for the clarifications.  I misunderstood; I knew PSCI was
preferred but somehow had it in my head that spin-table was just
a non-starter.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
