From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 17:22:14 +0000
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
Message-ID: <3caf0f3f-76e5-cb1e-7c0f-87ed5e1c2b86@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 16:32, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 12:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 21/02/17 11:07, Pavel Machek wrote:
>>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>>> "Power-On Suspend".
>>>>
>>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>>> an optional API in PSCI v1.0.
>>>
>>> If system supports "shallow" suspend, why does not PSCI implement it?
>>
>> Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
>> All it now needs is just to use existing "freeze" suspend mode in Linux.
> 
> How can Linux know if using "deep" suspend will allow to wake-up the system
> according to configured wake-up sources, or not?
>

I am not sure if we have such selective configuration of wakeup source
implemented in Linux.

ACPI specification has some provisions where each device can state if it
can specify device state in each system sleeping state that can wake the
system.

DT has no mechanism today to express this relations. I had brought up
this discussion in plumbers(2015). Refer slide 7 in [0]

And the way you are trying to do that is not correct IMO especially
making it just PSCI specific.

> Note that "it will not, ever" is an accepted answer.
>

IIUC, it's not implemented today. I can't talk about future ;), but your
proposal is horrible hack.

-- 
Regards,
Sudeep

[0]
https://linuxplumbersconf.org/2015/ocw//system/presentations/3051/original/wakeup_config.pdf
