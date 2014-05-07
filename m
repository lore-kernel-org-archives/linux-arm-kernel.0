From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 May 2014 11:39:43 -0300
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <5369EFA3.8070908@st.com>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
 <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
 <5369081D.5030400@st.com> <20140506200029.GD5858@pengutronix.de>
 <20140507020950.GB2794@dragon> <20140507033223.GB2798@dragon>
 <5369EFA3.8070908@st.com>
Message-ID: <CAOMZO5B2QCDmdFxNmcg3ow1p2CeodE43pSSqEN+Ye0Rtm3sW=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Wed, May 7, 2014 at 5:32 AM, Maxime Coquelin <maxime.coquelin@st.com> wrote:

> You are right. Sorry for the regression.
>
> I thought I tested it, as I had some table-based dividers in my test setup.
> After checking again, it appears that I didn't had the CLK_SET_RATE_PARENT
> flag set on these clocks, so I didn't entered the for loop...
>
> Could the fix be to initialize "up" variable to INT_MAX in _round_up_table
> (see below)?

This works fine for me:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

> I can send the patch if you are fine with it.
> I have no hardware to test on this week, I only have compiled this patch,
> not tested it.

Please submit your patch, thanks.
