From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Oct 2010 14:39:00 +0900
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for
	S/PDIF PCM audio
In-Reply-To: <20101005044304.GA26509@opensource.wolfsonmicro.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
Message-ID: <AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 1:43 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 05, 2010 at 11:19:35AM +0900, Jassi Brar wrote:
>> On Tue, Oct 5, 2010 at 10:10 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> > On Tue, Oct 5, 2010 at 7:42 AM, Mark Brown

> The reason I'm concerned about this is that I've had actual problems
> with users of your out of tree BSPs getting confused by similar code
> there.
Yes, past mistakes haunt us still.

> Since the clock API currently doesn't have a good way of resolving this
> perhaps a config option or something which masks the EPLL behaviour
> controllable and leaves it alone by default? ?That would show people how
> to use this chip feature without affecting the other subsystems so
> non-obviously.
Yes we can have a kconfig entry for 'Controllable EPLL' but that seems
orthogonal to ASoC because, for SMDKs, we choose to produce
accurate signals hence need to manipulate EPLL. The only point is
where to do it.
(our priority is accuracy of each IP's functioning rather than having
all parts of
SMDK playing nice with each other on such h/w design issues)

>> Btw, another important reason is that having EPLL manipulation in board-int
>> would result in code-duplication on other SMDK platforms as most have the
>> same clock routing options available in h/w and we want to use the same ASoC
>> machine driver for SoCs whenever possible.
>
> This doesn't seem such a big deal - you could create a shared file for
> the code under arch/arm.

I hope you noticed that this clock hierarchy is a _very_ board specific thing.
We can easily place SoCs' shared stuff in arch/arm/plat-samsung (or similar)
Any suggestions, where do we place code shared by SMDK-boards ?

Thanks
