From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 20:14:00 +0800
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <20131217105347.75954ad3@ipc1.ka-ro>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>
Message-ID: <20131217121358.GM6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 10:53:47AM +0100, Lothar Wa?mann wrote:
> > > +	if (soc_opp_index >= soc_opp_count) {
> > 
> > Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
> > the condition check below is good enough?
> > 
> > 	if (soc_opp_index == soc_opp_count)
> >
> it doen't harm to be on the safe side and use >= anyway!

Well, it may confuse reader.  At least, it took me some time understand
how that ">" condition will happen.  And it turns out never.

Shawn
