From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 May 2014 08:15:10 +0200
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <20140507020950.GB2794@dragon>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
 <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
 <5369081D.5030400@st.com> <20140506200029.GD5858@pengutronix.de>
 <20140507020950.GB2794@dragon>
Message-ID: <20140507061510.GE5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:09:51AM +0800, Shawn Guo wrote:
> > Here when a table entry matches the input div this function will return
> > exactly the input div. This means _next_div() will always return the
> > same value and clk_divider_bestdiv() has an infinite loop:
> > 
> > 	for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
> > 		...
> > 	}
> 
> Hmmm, isn't the first thing that _next_div() does to increment the input
> div?

Sorry, yes. You're right.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
