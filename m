From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 22 Jun 2011 11:31:35 +0900
Subject: [PATCH v2 1/4] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <4E002D18.2080401@linaro.org>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
	<4E002D18.2080401@linaro.org>
Message-ID: <BANLkTi=pv=y+1XC5bYEHgL1sy48JPztiOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 2:33 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> On Tuesday 21 June 2011 07:37 AM, MyungJoo Ham wrote:
>>
>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>
>> --
>> Changes from v1. Thanks so much for your valuable comments, Mark.
>> - Removed unnecessary initialization data
>> - Add __initdata where necessary
>> - Corrected a regulator name for ADC
>> ---
>> ?arch/arm/mach-exynos4/mach-nuri.c | ?622
>> ++++++++++++++++++++++++++++++++++++-
>> ?1 files changed, 621 insertions(+), 1 deletions(-)
>>
> Will it be possible to move PMIC specific defines to a common file and make
> appropriate calls in the board-specific file?
>
> In that way, we can re-use this PMIC code on some other boards (e.g.
> Insignal low-cost board Origen featuring Exynos4210 also features MAX8997).
>

Yes, we have tried creating PMIC defines at a seperated file in our
local repositories (still doing so in those repositories).
However, that ended up creating multiple PMIC defines (one PMIC define
file for each board); the connections between LDO# and devices are
different.

>
> --
> Tushar Behera
>


-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
