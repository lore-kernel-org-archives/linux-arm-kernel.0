From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 2 Sep 2016 11:03:54 +0100
Subject: [PATCH v2 9/9] arm64: Work around systems with mismatched cache
 line sizes
In-Reply-To: <20160826170034.GD15779@e104818-lin.cambridge.arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
 <1472203398-8751-10-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu_AyrQLdjf+1-QuZu3k2goT-_6Dk5mQbvP6XSmu30V4cQ@mail.gmail.com>
 <f2ff63f1-9cc7-6930-60eb-5f1fb8fde2e6@arm.com>
 <f72be21a-fd67-dc30-ca1b-278dd99821a2@arm.com>
 <20160826161627.GL30302@arm.com>
 <20160826170034.GD15779@e104818-lin.cambridge.arm.com>
Message-ID: <75d153e0-6771-f887-7960-24c3385a5487@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/16 18:00, Catalin Marinas wrote:
> On Fri, Aug 26, 2016 at 05:16:27PM +0100, Will Deacon wrote:
>> On Fri, Aug 26, 2016 at 02:08:01PM +0100, Suzuki K Poulose wrote:
>>> On 26/08/16 14:04, Suzuki K Poulose wrote:

>> It might be worth looking to see if we can pass the ctr as an extra
>> parameter to the assembly routines that need it. Then you can access it
>> easily from C code, and if you pass it as 0 that could result in the asm
>> code reading it from the h/w register, removing the need for the _raw
>> stuff you add.
>
> How often to we need to access a sanitised sysreg from assembly? AFAICT,
> CTR_EL0 is the first. If we only need it to infer the minimum cache line
> size, we could as well store the latter in a global variable and access
> it directly. If we feel brave, we could patch a "mov \reg, #x"
> instruction in the ?cache_line_size macros (starting with 32 by default,
> though to make it less cumbersome we'd have to improve the run-time
> patching code a bit).


With Ard's patches [1] to refactor the feature array, we can refer to named
CTR_EL0 feature register cleanly. I can rebase this series on top of that
if nobody has any objection.

[1] http://marc.info/?l=linux-arm-kernel&m=147263959504998&w=2


Suzuki
