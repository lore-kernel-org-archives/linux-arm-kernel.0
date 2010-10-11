From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Oct 2010 11:47:38 +0100
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver
	for S/PDIF PCM audio
In-Reply-To: <AANLkTindvBBOyWwkbwUo+oG31r8xSgCLbjuDNgvTNY_Q@mail.gmail.com>
References: <AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
	<AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
	<AANLkTin4skx+aiL2FXwWO1ekKqT2YWDd3SM1H5WnGkhC@mail.gmail.com>
	<00c401cb6520$9484ef90$bd8eceb0$%kim@samsung.com>
	<AANLkTikf4CAWm49Q_AfcfiQDBQUVcE_BC-a_4F7d8xOz@mail.gmail.com>
	<AANLkTinPXcjHcaM1puzz00Sfhob9Y-X4HGDDVGMTqhH5@mail.gmail.com>
	<AANLkTindvBBOyWwkbwUo+oG31r8xSgCLbjuDNgvTNY_Q@mail.gmail.com>
Message-ID: <20101011104737.GB16777@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 10:52:26AM +0900, Jassi Brar wrote:
> On Fri, Oct 8, 2010 at 6:07 PM, Seungwhan Youn <claude.youn@gmail.com> wrote:

> > Now, I'm almost finished 2nd patch for submit except this audio clock
> > setting. For now, I can only think that remove audio clock setting
> > from this machine code, and add audio clock settings in arch later(may
> > be after arch/arm/plat-samsung get EPLL policy as Mr. Kukjin said).

> > Is this okay?

> IMO neither of the method is much better than the other.

> If neither of the maintainers relent, maybe drop the clock setting altogether
> and mark the machine driver 'BROKEN' until the EPLL management is fixed?

I'm OK with having the code in the driver, I just want something there
that makes it more discoverable that it's there like a config option.
Having the driver log loudly when it reconfigures the EPLL would
probably also cover it.
