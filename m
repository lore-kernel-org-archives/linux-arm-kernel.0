From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Fri, 19 Nov 2010 10:47:18 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <8762vy4fki.fsf@sympatico.ca> (Bill Pringlemeir's message of
	"Mon, 15 Nov 2010 13:17:17 -0500")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
	<20101115153058.GG12986@rakim.wolfsonmicro.main>
	<87oc9qeg75.fsf@sympatico.ca>
	<BLU0-SMTP55EFC1F097F339783A2A30B8360@phx.gbl>
	<20101115162636.GH12986@rakim.wolfsonmicro.main>
	<8762vy4fki.fsf@sympatico.ca>
Message-ID: <BLU0-SMTP6392EE1086D2AEE817D758B83A0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 Nov 2010, bpringle at sympatico.ca wrote:

> No, I don't think it is an SSI protocol device either.  I think there
> are two internal ports and five external ports, at least on the IMX
> 25.  Maybe the documentation is cut and paste from another processor?

[snip]

> Thanks for you help.  I *think* I am getting closer to understanding
> this now.

I sent a service request to Freescale,

[Technical Support Freescale Semiconductor] 

   In reply to your Service Request SR 1-694170620: The i.MX25 AUDMUX
   Port1 and Port2 are connected to the internal SSI modules, the
   Port3 to Port7 are connected to external pins through the IOMUX
   module. The Port7 can be always used as external port, regardless
   of the CE bus mode. Should you need to contact us with regard to
   this message, please see the notes below.

It looks like the i.MX25 is a mix of the i.MX31 and i.MX35.  I think
it makes the most sense to change the audmux_port_string() to return
"SSI7" instead of "UNKNOWN" for this port and fix the loop indexes.

I will re-submit those patches later.

Regards,
Bill Pringlemeir.
