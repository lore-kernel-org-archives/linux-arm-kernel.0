From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 10:10:34 +0100
Subject: [PATCH v3 3/13] mmc: sunxi: Always set signal delay to 0 for A64
In-Reply-To: <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw@mail.gmail.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <67fd7dad745b49bb8edb7391655eaddf6f35160e.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw@mail.gmail.com>
Message-ID: <20170125091034.2cwnq7g72fndhuqz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Tue, Jan 24, 2017 at 09:16:12AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Experience have shown that the using the  autocalibration could severely
> > degrade the performances of the MMC bus.
> >
> > Allwinner is using in its BSP a delay set to 0 for all the modes but HS400.
> > Remove the calibration code for now, and add comments to document our
> > findings.
> 
> So doesn't this break some platforms using HS400? Or are you saying
> those are already broken?

Like Andre said, HS400 isn't supported at all, so there's no
regression or brokenness involved :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/716c21c2/attachment.sig>
