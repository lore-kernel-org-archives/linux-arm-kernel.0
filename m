From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 12 Nov 2009 15:37:07 +0100
Subject: [PATCH] ARM: Prefix revision number in /proc/cpuinfo
In-Reply-To: <20091112143020.GA21329@mail.gnudd.com>
References: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
	<20091112143020.GA21329@mail.gnudd.com>
Message-ID: <20091112143707.GO14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 03:30:20PM +0100, Alessandro Rubini wrote:
> > The revision field in /proc/cpuinfo is reported as hex number, so it
> > should have a '0x' prefix to make that clear. Otherwise, parsers
> > will take it as decimal number unless it contains a letter.
> 
> If the problem is real (I assume it is), why don't you fix all
> fields?
> 
> > -	seq_printf(m, "Revision\t: %04x\n", system_rev);
> > +	seq_printf(m, "Revision\t: 0x%04x\n", system_rev);
> >  	seq_printf(m, "Serial\t\t: %08x%08x\n",
> >  		   system_serial_high, system_serial_low);
> 
> "Serial", above, is hex as well.

Yes, but the serial number is more likely to be taken as string, I
thought. Anyway, below is a new patch.

Daniel
