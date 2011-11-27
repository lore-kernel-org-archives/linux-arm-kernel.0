From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 26 Nov 2011 19:07:37 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
 <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Nov 2011, Paul Walmsley wrote:

> Hi Beno?t,
> 
> a question about this patch.

...

> > +		.name		= "mipi_stm",
> > +		.pa_start	= 0x54161000,
> > +		.pa_end		= 0x54161fff,
> > +		.flags		= ADDR_TYPE_RT

> ... none of the address spaces above have the ADDR_TYPE_RT flag set.
> Without this flag set, the hwmod code won't know where to access the OCP 
> registers.

Ugh, it's above; I just missed it.  Sorry about that.

So just out of curiosity, do those SYSCONFIG registers in the STM address 
space apply to the entire DEBUGSS, or just the STM IP block?


- Paul
