From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Apr 2013 12:48:41 +0200
Subject: [PATCH 0/3] clk: Exynos: Register audio subsytem clocks using
 common clk framework
In-Reply-To: <CAAgF-Be1Hvkt=BDK913KTu66M4izxbuOuORQ8hyT-GZR1+ABnQ@mail.gmail.com>
References: <1365144043-17101-1-git-send-email-padma.v@samsung.com>
 <515EC996.8030904@samsung.com>
 <CAAgF-Be1Hvkt=BDK913KTu66M4izxbuOuORQ8hyT-GZR1+ABnQ@mail.gmail.com>
Message-ID: <5162A089.4030405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/06/2013 12:16 PM, Padma Venkat wrote:
> On Fri, Apr 5, 2013 at 6:24 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>>
>> From a brief look Exynos4 and Exynos5 Audio Subsystem CLKCON very similar.
>> I've just found bit 2 of 0x0381_0008 register is not used on Exynos5250.
> 
> I added bit 2 as i2s_bus gate clock or you are pointing to something else?

Sorry, I should have written "bit 1".

>> Additionally the Audio Subsystem Clock controller is present on S5PV210
>> SoCs and IMO compatible property you used is too generic. I would propose
>> to use at least:
>>
>> "samsung,s5pv210-audss-clock"    - for S5PV210
>> "samsung,exynos4210-audss-clock" - for Exynos4
>> "samsung,exynos5250-audss-clock" - for Exynos5
> 
> Different compatible names means different driver files for exynos4 and 5??

No, it would be same driver but with multiple entries in the of_match_table.

> I haven't seen any difference between Exynos4 and Exynos5 audio subsystem.
> Can't we maintain one for both? If any extra clock instance is added
> on newer SoCs
> anyway it gets added at the end of the list of clocks. Please correct
> me if I am wrong.

Sure, the differences between Exynos4 and Exynos5 audio subsystem are very
minor ones. So we could easily use one clock driver for those. Probably same
driver can be used for S5PV210, an any differences could be handled in the
driver based on the compatible property.


Thanks,
Sylwester

-- 
Sylwester Nawrocki
Samsung Poland R&D Center
