From: plyatov@gmail.com (Igor Plyatov)
Date: Sat, 11 Dec 2010 23:51:34 +0300
Subject: [PATCH] ata: pata_at91.c bugfix for high master clock
In-Reply-To: <20101211214044.37b866e0@realm>
References: <1292038651-5578-1-git-send-email-plyatov@gmail.com>
	<20101211214044.37b866e0@realm>
Message-ID: <1292100694.27634.25.camel@homepc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergey,

> > @@ -109,6 +111,11 @@ static void set_smc_timing(struct device *dev,
> >  	/* (CS0, CS1, DIR, OE) <= (CFCE1, CFCE2, CFRNW, NCSX)
> > timings */ ncs_read_setup = 1;
> >  	ncs_read_pulse = read_cycle - 2;
> > +	if (ncs_read_pulse > NCS_RD_PULSE_LIMIT) {
> > +		ncs_read_pulse = NCS_RD_PULSE_LIMIT;
> > +		dev_dbg(dev, "ncs_read_pulse limited to maximal
> > value %lu\n",
> 
> arguably 'dev_warn' would be better in this case

Done as "PATCH v2".

Best regards!
--
Igor Plyatov
