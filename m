From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Nov 2013 14:37:13 +0100
Subject: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and 9
In-Reply-To: <5299DA42.2030508@kernel.org>
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com>
 <5299D6E6.2080100@kernel.org> <5299D7D1.3050801@kernel.org>
 <CAHXqBF++HsFLG84vQjWeb=QmgE4yjJqYEj_zLS34m2WMDJ2CRA@mail.gmail.com>
 <5299D9B7.3090404@kernel.org> <5299DA42.2030508@kernel.org>
Message-ID: <20131130133713.GA3002@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 12:29:54PM +0000, Jonathan Cameron wrote:
> On 11/30/13 12:27, Jonathan Cameron wrote:
> > On 11/30/13 12:24, Micha? Miros?aw wrote:
> >> 2013/11/30 Jonathan Cameron <jic23@kernel.org>:
> >>> On 11/30/13 12:15, Jonathan Cameron wrote:
> >>>> On 11/19/13 10:36, Maxime Ripard wrote:
> >>>>> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>>>>
> >>>>> The mxs LRADC is able to read an internal die temperature sensor. The
> >>>>> temperature has to be calculated from the value read on channel 8 and channel 9.
> >>>>> To be able to expose the result to hwmon, implement iio channel 8 as
> >>>>> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
> >>>>> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through the in kernel
> >>>>> provider/consumer mechanism.
> >>>>>
> >>>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>>>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> >>>> As this is still in staging, I think we can get away with the resulting
> >>>> ABI change from this patch.
> >>>>
> >>>> Applied to the togreg branch of iio.git
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan
> >>> Having said that, there is an odd bit inline that I've just dropped whilst
> >>> applying the patch.  Shout if I've done this wrong.
> Given issues below and the substantial changes that have occured in this driver, could
> your please rebase it and repost.

I will.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131130/8f5999b1/attachment.sig>
