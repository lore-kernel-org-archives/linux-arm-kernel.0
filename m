From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Jul 2012 12:50:42 +0200
Subject: [PATCH v2] clk: __clk_set_parent: set uninitialized variable
In-Reply-To: <CAJOA=zN1FoFQmuht1R06n2xQbZ=g0aqN=5Lo2-v8MQx55qHmeg@mail.gmail.com>
References: <1341214902-15667-1-git-send-email-mkl@pengutronix.de>
 <4FF15EDF.7030806@ti.com>
 <CAJOA=zN1FoFQmuht1R06n2xQbZ=g0aqN=5Lo2-v8MQx55qHmeg@mail.gmail.com>
Message-ID: <20120703105042.GJ22016@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jul 02, 2012 at 04:29:10PM -0700, Turquette, Mike wrote:
> On Mon, Jul 2, 2012 at 1:42 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > On Monday 02 July 2012 01:11 PM, Marc Kleine-Budde wrote:
> >>
> >> This patch fixes the following warning:
> >>
> >> ? ? ?drivers/clk/clk.c: In function '__clk_set_parent':
> >> ? ? ?drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in
> >> this function [-Wuninitialized]
> >>
> >> which has been introduced with commit:
> >>
> >> ? ? ?commit 7975059db572eb47f0fb272a62afeae272a4b209
> >> ? ? ?Author: Rajendra Nayak<rnayak@ti.com>
> >> ? ? ?Date: ? Wed Jun 6 14:41:31 2012 +0530
> >>
> >> ? ? ? ? ?clk: Allow late cache allocation for clk->parents
> >>
> >> This patch applies to linux-3.5-rc5
> >>
> >> Cc: Rajendra Nayak<rnayak@ti.com>
> >> Signed-off-by: Marc Kleine-Budde<mkl@pengutronix.de>
> >> ---
> >> Hello,
> >>
> >> here an updated version. Changes since v1:
> >> - Set i to clk->num_parents as Uwe pointed out.
> >
> >
> > I started looking at how to avoid this initing
> > of i to clk->parents (which is correct for the logic
> > used below, but somehow seems error prone if someone
> > happens to change the logic without noticing the init
> > part)
> > This is what I came up with, not tested at all, but
> > worth considering if Mike dislikes the idea of initing
> > i to clk->parents.
> >
> 
> Hi Rajendra and Marc,
> 
> I prefer the code flow in Rajendra's change.  It seems more readable
> and has a negative diffstat ;-)
> 
> $ git diff --stat
>  drivers/clk/clk.c |   28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> Rajendra, can you test and send a proper patch for the same?  Thanks
> Marc for sending your two previous patches.  I don't think that I will
> Cc this one to stable since it falls under the category of
> "theoretical but not yet observed" bugs.
Maybe it's not observed yet only because
7975059db572eb47f0fb272a62afeae272a4b209 isn't deeply tested yet? Don't
know, just a guess.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
