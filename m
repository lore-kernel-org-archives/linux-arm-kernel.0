From: Victor.Boivie@sonyericsson.com (Boivie, Victor)
Date: Thu, 7 Apr 2011 13:38:05 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <20110407105850.GJ13963@pengutronix.de>
References: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
	<1302172525.24493.7.camel@t41.thuisdomein>
	<20110407105850.GJ13963@pengutronix.de>
Message-ID: <56A05FDF86209947BB88FDF67E6D4A1073F0B97360@SELDMBX04.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This suggests the parameters provided by the boot loader will override
> > corresponding parameters of the default kernel command string. Is that
> > correct (for all possible parameters)?
> >
> > Either way, shouldn't it be documented, perhaps in this help text, what
> > will happen if a parameter of the default kernel command string and a
> > parameter provided by the boot loader somehow conflict?
> Then you will end up with both parameters I guess. What happens depends
> on the parameter in question I guess. IMHO the description is fine.
> But I wonder if the new mechanism is useful in the end.

The way it was intended from my point of view was to only specify (in 
CONFIG_CMDLINE) the parameters that the boot loader doesn't specify. 

We use it to let the boot loader (which is generic and whose config is
rather tricky to change) specify startup reasons and other probed 
information that the kernel can't probe itself, and let the kernel handle
the rest, such as specifying memory regions and console tty's.

Thanks for reviewing, both of you.

Best regards,
Victor Boivie
