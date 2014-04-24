From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 12:48:41 +0200
Subject: [PATCH 2/4] ARM: S3C24XX: trim down debug uart handling
In-Reply-To: <20140424103455.GJ26756@n2100.arm.linux.org.uk>
References: <1544889.hRy2JpKRQe@phil> <1410234.AYxfyBcLWB@phil>
 <20140424103455.GJ26756@n2100.arm.linux.org.uk>
Message-ID: <24114123.4LqcQi8gAH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. April 2014, 11:34:55 schrieb Russell King - ARM Linux:
> On Thu, Apr 24, 2014 at 12:24:31PM +0200, Heiko St?bner wrote:
> > +choice
> > +	prompt "S3C24XX low-level debugging port type"
> > +	depends on DEBUG_LL && ARCH_S3C24XX
> > +
> > +	config DEBUG_S3C24XX_UART_S3C2440
> > +		bool "S3C2440 uart type"
> > +		help
> > +		  Select this if you're debugging S3C2416, S3C2440, S3C2442,
> > +		  S3C2443 or S3C2450 SoCs.
> > +
> > +	config DEBUG_S3C24XX_UART_S3C2410
> > +		bool "S3C2410 uart type"
> > +		help
> > +		  Select this if you're debugging S3C2410 or S3C2412 SoCs.
> > +endchoice
> 
> Why does this need to be a separate choice statement?  What's special
> about S3C24XX?  Is there something wrong with the main choice statement
> just above this where everyone else lists their debugging UART?

The special case is that s3c24xx as architecture has two different uart types. 
Everything else is the same so I didn't want to duplicate the s3c_debug_uartX 
entries.

The other option would have been to duplicate these, like having

- s3c_debug_uart[0-3] for the more common s3c2440 type and
- s3c2410_debug_uart[0-3] for the named type

I guess, judging from your comment this would be better?
[or I'm just overlooking the obvious third way :-) ]


Heiko
