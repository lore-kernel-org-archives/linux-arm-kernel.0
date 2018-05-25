From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 25 May 2018 15:45:59 +0300
Subject: [GIT PULL 2/5] memory: tegra: Changes for v4.18-rc1
In-Reply-To: <20180525121158.dk5hv525ilakmshz@localhost>
References: <20180518142245.20242-1-thierry.reding@gmail.com>
 <20180518142245.20242-2-thierry.reding@gmail.com>
 <20180525121158.dk5hv525ilakmshz@localhost>
Message-ID: <de40dfa2-90cf-01f6-dc58-3a60afcf4e39@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.05.2018 15:11, Olof Johansson wrote:
> On Fri, May 18, 2018 at 04:22:42PM +0200, Thierry Reding wrote:
>> Hi ARM SoC maintainers,
>>
>> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>>
>>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-memory
>>
>> for you to fetch changes up to bef89a8d81ca97aca864778746b110cf52847868:
>>
>>   memory: tegra: Remove Tegra114 SATA and AFI reset definitions (2018-05-18 12:33:02 +0200)
>>
>> Thanks,
>> Thierry
>>
>> ----------------------------------------------------------------
>> memory: tegra: Changes for v4.18-rc1
>>
>> This contains some cleanup of the memory controller driver as well as
>> unification work to share more code between Tegra20 and later SoC
>> generations. Also included are an implementation for the hot resets
>> functionality by the memory controller which is required to properly
>> reset busy hardware.
>>
>> ----------------------------------------------------------------
>> Dmitry Osipenko (14):
>>       dt-bindings: memory: tegra: Add hot resets definitions
>>       memory: tegra: Do not handle spurious interrupts
>>       memory: tegra: Setup interrupts mask before requesting IRQ
>>       memory: tegra: Apply interrupts mask per SoC
>>       memory: tegra: Remove unused headers inclusions
>>       memory: tegra: Squash tegra20-mc into common tegra-mc driver
>>       memory: tegra: Introduce memory client hot reset
>>       memory: tegra: Add Tegra20 memory controller hot resets
>>       memory: tegra: Add Tegra30 memory controller hot resets
>>       memory: tegra: Add Tegra114 memory controller hot resets
>>       memory: tegra: Add Tegra124 memory controller hot resets
>>       memory: tegra: Register SMMU after MC driver became ready
>>       dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions
>>       memory: tegra: Remove Tegra114 SATA and AFI reset definitions
>>
>> Thierry Reding (1):
>>       memory: tegra: Add Tegra210 memory controller hot resets
> 
> Looks like this is just additional/proper resets, are there any backwards
> compatibility concerns with older device trees or new assumptions of properties
> that should be handled?

Hello Olof,

AFAIK, memory resets never been used anywhere before. The device drivers would
have to take into account the backwards compatibility, like for example we do in
the proposed video-decoder patch that optionally utilizes the MC reset [0].

[0] https://patchwork.ozlabs.org/patch/917176/
