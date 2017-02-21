From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 16:51:48 +0000
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <CAMuHMdUAcRVLzDZCZucAt0agGZynQtqhWeh7yPaBrogCYhRW4g@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <08c5dcf3-9d7c-33ff-f801-8f94f630f49b@arm.com>
 <CAMuHMdUAcRVLzDZCZucAt0agGZynQtqhWeh7yPaBrogCYhRW4g@mail.gmail.com>
Message-ID: <016dd5fc-08c2-0084-5332-2992ab95f134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 16:23, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>> "Power-On Suspend".
>>>
>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>> an optional API in PSCI v1.0.
>>>
>>> List the available system suspend modes:
>>>
>>>     $ cat /sys/power/mem_sleep
>>>     s2idle shallow [deep]
>>>
>>> Suspend to "shallow" mode:
>>>
>>>     $ echo shallow > /sys/power/mem_sleep
>>>     $ echo mem > /sys/power/state
>>>
>>
>> I don't have the links to such previous attempts handy, but we have
> 
> Don't worry, I did read earlier discussions about implementing shallow mode.
> 

In short or just to summarize in one line, just use "freeze"(a.k.a
suspend-to-idle suspend mode)

-- 
Regards,
Sudeep
