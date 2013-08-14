From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Aug 2013 13:50:52 -0500
Subject: [GIT PULL] Highbank fixes for 3.12
In-Reply-To: <87li4445tj.fsf@kernel.org>
References: <520AF2ED.9030900@gmail.com>
	<87li4445tj.fsf@kernel.org>
Message-ID: <CAL_Jsq+4hpsCM5aNt60+Oe5=Mt1SWrAwskahS+JbXYuHRRcMuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 11:04 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Hi Rob,
>
> Rob Herring <robherring2@gmail.com> writes:
>
>> Kevin, Olof,
>>
>> Please pull highbank updates for 3.12.
>>
>> There's one trivial core ARM code change in the series to allow a
>> DMA_ZONE size of 4GB. I believe this should not conflict with Russell's
>> DMA mask series.
>>
>> Rob
>>
>> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>>
>>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>>
>> are available in the git repository at:
>>
>>   git://sources.calxeda.com/kernel/linux.git
>> tags/highbank-lpae-fixes-for-3.12
>>
>> for you to fetch changes up to ce3ec1d61c5ed6af3ceaace6f57acd588c41b4d6:
>>
>>   ARM: highbank: fix debug uart virtual address for LPAE (2013-08-13
>> 20:50:16 -0500)
>>
>> ----------------------------------------------------------------
>> A set of fixes for highbank to enable LPAE and selecting of necesssary
>> ARM errata.
>>
>> ----------------------------------------------------------------
>> Rob Herring (6):
>>       ARM: use phys_addr_t for DMA zone sizes
>>       ARM: highbank: enable DMA zone for LPAE
>>       ARM: highbank: select ARCH_HAS_HOLES_MEMORYMODEL
>>       ARM: highbank: select required errata work-arounds
>>       ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
>
> This one seems to have broken the AMBA PL08x DMA driver, and is still
> objected to by Russell, so I'll drop this one for now.

Exynos does the same selection, but I guess it is not multi-platform
though and doesn't select ARM_AMBA.

>>       ARM: highbank: fix debug uart virtual address for LPAE
>
> The rest look OK and I can pull them if the rest are OK without the
> objectionable one.  Let me know if that's OK, or you prefer to wait for
> resolution.

Yes, I'm fine with dropping this one for now.

Rob
