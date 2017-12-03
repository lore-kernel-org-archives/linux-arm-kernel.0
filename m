From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sun, 3 Dec 2017 17:26:11 +0100
Subject: [GIT PULL] revert ARM SCPI changes for v4.15-rc1
In-Reply-To: <20171203010435.6ycn75rxss5yiixe@localhost>
References: <7hlgimns2m.fsf@baylibre.com>
 <20171203010435.6ycn75rxss5yiixe@localhost>
Message-ID: <19697169-9209-ba59-781f-e79e15961fca@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.12.2017 um 02:04 schrieb Olof Johansson:
> On Fri, Dec 01, 2017 at 11:53:05AM -0800, Kevin Hilman wrote:
>> Arnd, Olof,
>>
>> These ARM SCPI changes caused SCPI regressions resulting in CPUfreq
>> failures on most Amlogic SoCs (found by kernelci.org.)
>>
>> Unfortunately, this was not caught in linux-next due to other
>> bugs/panics on these platforms masking this problem so we've only found
>> it since we've fixed the other issues.
>>
>> Since we're already in the -rc cycle, I'd prefer to revert to a known
>> working state (that of v4.14) rather than finding/reverting a subset,
>> which would just lead to another untested state.
>>
>> These changes can then have some time to be better reviewed and tested
>> and resubmitted for v4.16.
>>
>> I've tested this revert on the affect Amlogic SoCs and verified that
>> we're back to the previous (working) condition.
>>
>> Also, I'm sending the pull directly to arm-soc instead of Sudeeep
>> because I understand that Sudeep is currently out-of-office and unlikely
>> to be able to address this himself during the -rc cycle.
>>
> 
> Sounds like the right approach here. I've merged this and added the above text
> to the merge commit as well.
> 
I can't reproduce the issue on my systems, however I'm quite sure that commit
931cf0c53e69 "firmware: arm_scpi: pre-populate dvfs info in scpi_probe" causes
the problem.
I could re-submit the series w/o this patch, the other patches then need some
re-basing.

I'd include a patch addressing the following question from Kevin because I was
asking myself the same thing too:
"Also, is this the expected result for the pre-1.0 firmware:
scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version"

In case a legacy firmware doesn't provide version information I propose to
print the following message instead:
scpi_protocol scpi: SCP Protocol legacy pre-1.0 firmware

The series could be applied to a devel branch first to give the Baylibre
Amlogic team some time for testing.

Rgds, Heiner

> 
> -Olof
> 
