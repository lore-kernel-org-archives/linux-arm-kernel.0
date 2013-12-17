From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 17 Dec 2013 10:53:47 +0100
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <20131217025616.GC6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
Message-ID: <20131217105347.75954ad3@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Mon, Dec 16, 2013 at 04:14:10PM -0500, Anson Huang wrote:
> > on i.MX6Q, cpu freq change need to follow below flows:
> > 
> > 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
> > table from dts;
> > 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
> > VDDARM, if VDDPU is off, no need to change it;
> > 3. when cpu freq is scaling down, need to decrease VDDARM voltage before
> > VDDSOC/PU, if VDDPU is off, no need to change it;
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
[...]
> > +	if (soc_opp_index >= soc_opp_count) {
> 
> Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
> the condition check below is good enough?
> 
> 	if (soc_opp_index == soc_opp_count)
>
it doen't harm to be on the safe side and use >= anyway!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
