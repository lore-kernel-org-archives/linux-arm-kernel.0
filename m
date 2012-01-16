From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 16 Jan 2012 21:52:59 +0100
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
In-Reply-To: <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
References: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
Message-ID: <201201162152.59997.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Jan 16, 2012 at 5:01 PM, Fabio Estevam
> 
> <fabio.estevam@freescale.com> wrote:
> > From: Fabio Estevam <festevam@gmail.com>
> > 
> > Selecting audio on a mx28evk the saif driver was failing:
> > 
> > [    0.660000] saif0_clk_set_rate: divider writing timeout
> > [    0.670000] mxs-sgtl5000: probe of mxs-sgtl5000.0 failed with error
> > -110 [    0.670000] ALSA device list:
> > [    0.680000]   No soundcards found.
> > 
> > The timeout on saif0_clk_set_rate was due to the wrong condition for the
> > end of loop.
> > 
> > After fixing it, the audio driver can be correctly probed and becomes
> > functional.
> > 
> > While at it, fix the other locations where the similar issue occurs.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Please disregard this version.

I see ... ignore my previous comment ;-)

M
