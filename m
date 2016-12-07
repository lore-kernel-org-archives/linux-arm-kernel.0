From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 07 Dec 2016 12:41:29 +0100
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
In-Reply-To: <CAOesGMi6gqNLUZw_bQZE2foBts0c70z57bHcMVg1hVZ_E4easg@mail.gmail.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161206190338epcas3p2f1fbd4ee54e51c055e9258843046964b@epcas3p2.samsung.com>
 <CAOesGMi6gqNLUZw_bQZE2foBts0c70z57bHcMVg1hVZ_E4easg@mail.gmail.com>
Message-ID: <4222703.VA8eKM008t@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, December 06, 2016 11:03:34 AM Olof Johansson wrote:
> On Tue, Dec 6, 2016 at 4:38 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Hi,
> >
> > This RFC patchset starts convertion of ARM defconfigs to use kconfig
> > fragments and dynamically generate defconfigs.  The goals of this
> > work are to:
> 
> You don't provide any motivation as to why this is better. As far as I

Benefits are:

- no code duplication (this initial patchset alone removes ~1700 lines
  from defconfigs without any change in functionality)

- prevention of "multi" defconfigs (i.e. multi_v7_defconfig) going out
  of sync with "SoC-family" ones (i.e. exynos_defconfig) - there will
  be just one place to update when changing things

- possibility to add support for more optimized defconfigs (i.e. board
  specific ones) in the future without duplicating the code

- making it easier to define arch specific parts of defconfigs in
  the future if we decide on doing it (i.e. we may want to enable
  things like CONFIG_SYSVIPC for all defconfigs)

> am concerned it'll just be a mess.
> 
> So:
> 
> Nack. So much nack. I really don't want to see a proliferation of
> config fragments like this.
> 
> I had a feeling it was a bad idea to pick up that one line config
> fragment before, since it opened the door for this kind of mess. :(

Like I said in the cover-letter I'm not satisfied with the current
patches and they have much room for improvement.

However I see that you don't like the idea itself... :(

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
