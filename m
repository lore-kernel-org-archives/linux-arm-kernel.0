From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 09:50:12 +0000
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <20130327205606.GN10155@atomide.com>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <20130306175120.GP11806@atomide.com> <201303062013.16302@pali>
 <201303241526.59275@pali> <20130327205606.GN10155@atomide.com>
Message-ID: <20130328095011.GS30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 01:56:07PM -0700, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [130324 07:31]:
> > it is possible to upstream errata 430973 workaround for RX-51?
> 
> I think we should make the SMC handling a generic function for ARM.
> 
> AFAIK just the SMC call numbering is different for various
> implementations. So the handler and passing of the parameters
> seems like it should be generic.

SMC calls vary greatly in how they are handled.  The only thing that's
generic is issuing the SMC call.  All the setup and what arguments are
required are completely different from SoC to SoC.

For example, some SoCs require arguments passed via memory.  Others like
OMAP its via registers.
