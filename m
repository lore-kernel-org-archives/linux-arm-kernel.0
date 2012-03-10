From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 13:18:47 -0800
Subject: [GIT PULL] mach/io.h clean-up and removal
In-Reply-To: <4F5BA82C.1040400@gmail.com>
References: <4F58DD30.4060704@gmail.com>
 <CAOesGMi1pD+1BEkXSGDA8k6UC2DD65QYt3Z_59McFkgWrdqehQ@mail.gmail.com>
 <4F5BA82C.1040400@gmail.com>
Message-ID: <CAOesGMjdErqMaMjH9DUirWn9CXbooHab-CJ-0k+qnZ6Zcy1XQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 11:14 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 03/10/2012 12:20 PM, Olof Johansson wrote:
>> Hi,
>>
>> On Thu, Mar 8, 2012 at 8:24 AM, Rob Herring <robherring2@gmail.com> wrote:
>>> Arnd, Olof,
>>>
>>> Please pull the mach/io.h cleanup series for 3.4. This does not include
>>> the PCI i/o mapping changes. In hopes of testing, I'll wait until 3.5
>>> for that. Although, it seems no one has devices with i/o.
>>>
>>> I'm sending this to you rather than Russell as it is based on at91 and
>>> omap cleanup branches in arm-soc tree.
>>>
>>> Rob
>>>
>>> The following changes since commit d50673ed97a7ce609cf62bcd40c57517ada31806:
>>>
>>> ?Merge remote-tracking branch 'arm-soc/at91/base2+cleanup' into
>>> cleanup-base (2012-03-04 22:00:46 -0600)
>>>
>>> are available in the git repository at:
>>>
>>> ?git://sources.calxeda.com/kernel/linux.git io-cleanup-for-3.4
>>
>> I've pulled this into next/cleanup2. Nice diffstat!
>>
>
> Actually, Arnd just found some abusers of __io() that I need to fix
> first. They are using __io() to cast defines to a void __iomem * ptr. I
> should have something out for review soon. So please drop this and I'll
> send a new pull request.


Rats. I saw the discussion but didn't think of it when I was doing
pulls this morning.

I'll revert it in for-next but keep it in next/cleanup2, so please
just do an incremental pull request for additional patches.


Thanks,

-Olof
