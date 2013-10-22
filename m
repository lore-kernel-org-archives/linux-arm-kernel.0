From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 22 Oct 2013 11:49:47 +0200
Subject: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131021155927.GB4255@core.coreip.homeip.net>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
 <20131021155927.GB4255@core.coreip.homeip.net>
Message-ID: <20131022114947.30dc9c07@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> >  
> > +	if (ts->of)
> > +		return tsc2007_get_pendown_state_dt(ts);
> > +
> >  	if (!ts->get_pendown_state)
> >  		return true;
> 
> Instead of special casing "if (ts->of)" all over the place why don't you
> set up the device structure as:
> 
> 	if (<configuring_tsc2007_form_dt>)
> 		ts->get_pendown_state = tsc2007_get_pendown_state_dt;
> 
> and be done with it?
>
I also thought about that, but the existing function does not have any
parameters, while the DT version of get_pendown_state() requires to get
the GPIO passed to it somehow.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
