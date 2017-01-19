From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Jan 2017 22:04:23 +0100
Subject: [PATCH v2 3/7] clk: sunxi-ng: Implement multiplier maximum
In-Reply-To: <CAGb2v65K8zQvHbhwZ6b6VhO6egXVQN4agHQ1JT8rkHzNsAEUtw@mail.gmail.com>
References: <cover.8762813dc78858261716126c700983d4aee00458.1484035021.git-series.maxime.ripard@free-electrons.com>
 <ab8ef79d63fc09c3eaa556d299832ec06e9869cf.1484035021.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65K8zQvHbhwZ6b6VhO6egXVQN4agHQ1JT8rkHzNsAEUtw@mail.gmail.com>
Message-ID: <20170119210423.5kjs3envfosjlsmr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 16, 2017 at 01:58:18PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 10, 2017 at 3:57 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu_mult.c |  4 ++--
> >  drivers/clk/sunxi-ng/ccu_mult.h | 10 ++++++----
> >  drivers/clk/sunxi-ng/ccu_nk.c   |  8 ++++----
> >  drivers/clk/sunxi-ng/ccu_nkm.c  |  8 ++++----
> >  drivers/clk/sunxi-ng/ccu_nkmp.c |  8 ++++----
> >  drivers/clk/sunxi-ng/ccu_nm.c   |  4 ++--
> >  6 files changed, 22 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
> > index bf5e11c803f9..fccfe1e1961a 100644
> > --- a/drivers/clk/sunxi-ng/ccu_mult.c
> > +++ b/drivers/clk/sunxi-ng/ccu_mult.c
> > @@ -41,7 +41,7 @@ static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
> >         struct _ccu_mult _cm;
> >
> >         _cm.min = 1;
> > -       _cm.max = 1 << cm->mult.width;
> > +       _cm.max = cm->mult.max ?: 1 << cm->mult.width;
> 
> Should you also factor in the offset when providing the default
> value for max? Otherwise you might end up with a value that is
> actually not progammable?
> 
> Say if offset is 1, then max would be 1 << width.
> But if offset is 0, then max would have to be (1 << width) - 1,
> as (1 << width) is not valid.

Ah, yes, that's true. I'll fix it.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/d2beb4bd/attachment.sig>
