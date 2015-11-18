From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Wed, 18 Nov 2015 12:09:42 +0100
Subject: Minimal support for dm814x
In-Reply-To: <CAALWOA8bEeLtO-QmyiS9H-z2-pToc-HY3HPuTEsmvZ2BSWf75Q@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
 <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
 <20151112174155.GM3218@atomide.com>
 <CAALWOA9o80rhaqwaa6=XxmNN1FcWzHDXiaqkqFVO81CAMX=04w@mail.gmail.com>
 <CAALWOA-29pK=GbNKhdY=4oJzhnueVxNAPruu9Uacqi5vMJN=OA@mail.gmail.com>
 <20151113145216.GC2517@atomide.com>
 <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
 <D5E377BD-5AAE-4302-B2C3-2B17A00892B5@audioscience.com>
 <CAALWOA8bEeLtO-QmyiS9H-z2-pToc-HY3HPuTEsmvZ2BSWf75Q@mail.gmail.com>
Message-ID: <78B56424-A35F-495E-B9AA-1638AC37359D@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 Nov 2015, at 11:01, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> On 18 November 2015 at 09:26, Delio Brignoli <dbrignoli@audioscience.com> wrote:
>>> This works in principle, but both minimizing the DCO and (often
>>> needlessly) using the fractional multiplier seem like recipes to
>>> maximize the clock jitter. Mind you, I don't know how much jitter
>>> we?re talking about here, I don't recall having seen specs about this.
>> 
>> We haven?t seen any specs either but testing shows that changing DCO mode causes
>> the PLL to lose lock at least temporarily.
> 
> Losing lock on reconfiguration is entirely a separate matter from
> clock jitter.

Sure, I just wanted to report a case in which the implementation you mention does something which may be undesirable.

> The fractional multiplier works by essentially by
> alternating between the nearest integer multiplier values. This will
> be smoothed out by the loop filter, but it?s not going to vanish.

[?]

> Now DPLLLJ will presumably do better, but without actual specs the
> safe option is to avoid the fractional multiplier altogether.

Still FYI, using adpll_ti814x.c from the linux-omap3 tree from the Arago project (i.e. the one you are talking about) hacked to prefer searching for neighbouring m2 values to DCO switching works OK for us (i.e. resulting jitter is low enough for our audio applications).

?
Delio
