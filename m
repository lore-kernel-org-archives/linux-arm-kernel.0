From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 29 Oct 2013 09:53:32 +0100
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131029020603.GH2839@S2101-09.ap.freescale.net>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMjB6D3owftDUfmMbVNx8_EtY9-RXoGbS3Rmry4FQhSfZQ@mail.gmail.com>
 <20131028081408.GF2839@S2101-09.ap.freescale.net>
 <CAOesGMijji0JBJqne_j8kPedYFF82U7fh7KS92PV1hJztJXE6w@mail.gmail.com>
 <20131029020603.GH2839@S2101-09.ap.freescale.net>
Message-ID: <20131029095332.5d926e8b@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Mon, Oct 28, 2013 at 10:46:02AM -0700, Olof Johansson wrote:
> > By the way, the errata document says that you must write it twice
> > within one 32kHz clock period. You might want to write it three times
> > just in case two of them happen to straddle that period by pure bad
> > luck. I'm guessing it's rare enough that you haven't been able to
> > reproduce it though.
> 
> With CPU running at hundred MHz, two writes in the row should not
> straddle one 32kHz clock period - 31.25 us.
> 
But they still may end up in adjacent periods of the 32MHz
clock. If both writes have to happen within the same period of the
clock, the third write may be necessary to guarantee this.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
