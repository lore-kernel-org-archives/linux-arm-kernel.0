From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 18:17:18 +0900
Subject: [PATCH v2 1/4] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <4E0164E8.8060708@linaro.org>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
	<4E002D18.2080401@linaro.org>
	<BANLkTi=pv=y+1XC5bYEHgL1sy48JPztiOg@mail.gmail.com>
	<4E0164E8.8060708@linaro.org>
Message-ID: <00bf01cc30bd$350b7fc0$9f227f40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> 
> On Wednesday 22 June 2011 08:01 AM, MyungJoo Ham wrote:
> > On Tue, Jun 21, 2011 at 2:33 PM, Tushar Behera<tushar.behera@linaro.org>
> wrote:
> >> On Tuesday 21 June 2011 07:37 AM, MyungJoo Ham wrote:
> >>>
> >>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
> >>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> >>>
> >>> --
> >>> Changes from v1. Thanks so much for your valuable comments, Mark.
> >>> - Removed unnecessary initialization data
> >>> - Add __initdata where necessary
> >>> - Corrected a regulator name for ADC
> >>> ---
> >>>   arch/arm/mach-exynos4/mach-nuri.c |  622
> >>> ++++++++++++++++++++++++++++++++++++-
> >>>   1 files changed, 621 insertions(+), 1 deletions(-)
> >>>
> >> Will it be possible to move PMIC specific defines to a common file and make
> >> appropriate calls in the board-specific file?
> >>
> >> In that way, we can re-use this PMIC code on some other boards (e.g.
> >> Insignal low-cost board Origen featuring Exynos4210 also features MAX8997).
> >>
> >
> > Yes, we have tried creating PMIC defines at a seperated file in our
> > local repositories (still doing so in those repositories).
> > However, that ended up creating multiple PMIC defines (one PMIC define
> > file for each board); the connections between LDO# and devices are
> > different.
> >
> In that case, we can first post the Origen board support and PMIC code
> on the ML, then we would see if we can consolidate.
> 
> That looks more logical as per Mark's suggestion also.
> >>

Hi Tushar,

When you need to add similar or same functionality on your board, you can/should move it in common part.
Maybe 'should'...basically, nobody will apply same function into both place...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
