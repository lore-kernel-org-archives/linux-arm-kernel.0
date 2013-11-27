From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Nov 2013 11:00:55 +0000
Subject: ACPI
In-Reply-To: <20131126233224.GA21189@srcf.ucam.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131126233224.GA21189@srcf.ucam.org>
Message-ID: <CAHkRjk4_hee1v=GvS=fDCw4AE8bFWfQ1ATXVNXHQBNsyO7s=RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2013 23:32, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Nov 26, 2013 at 05:11:23PM -0600, Matt Sealey wrote:
>> But I can't think of a reason why an extension or companion to PSCI
>> couldn't do it, and why you WOULDN'T want to do this as an API
>> implemented via a secure monitor interface which is architecturally
>> defined on ARM where security extensions are present. I can't imagine
>> a reason why it couldn't be done over IPMI to some microcontroller or
>> dedicated external component, for the case of fans and chassis
>> components and tedious other stuff.
>
> Primarily because people want solutions that aren't tied to having an
> entirely separate computer running its own embedded OS. The likely
> alternative to doing things in ACPI would be to do them in TrustZone,
> and let's not encourage that. A significant proportion of the bugs we
> see on x86 are down to SMM code that we can't see, let alone debug. It's
> much easier to handle bugs in code that runs in the same context as the
> OS.

I agree. While I'm pushing for standard firmware interfaces like PSCI
on ARMv8 (Power State Coordination Interface for those who haven't
heard of it yet), I would limit it to things that can only be done
(safely) in secure monitor mode (EL3) like CPU power management (and
that's hotplug/idle, not DVFS).

-- 
Catalin
