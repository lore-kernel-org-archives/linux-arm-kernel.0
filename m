From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 13 Oct 2015 15:26:43 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <561CDF2F.3090608@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se> <561238A9.1060406@lysator.liu.se>
 <20151005150032.GA12137@odux.rfo.atmel.com>
 <561292AC.8060408@lysator.liu.se> <561BCE33.2050904@lysator.liu.se>
 <561BDC32.2080401@atmel.com> <561CDF2F.3090608@lysator.liu.se>
Message-ID: <20151013132643.GD11227@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Oct 13, 2015 at 12:38:39PM +0200, Peter Rosin wrote:
> On 2015-10-12 18:13, Cyrille Pitchen wrote:
> > Le 12/10/2015 17:13, Peter Rosin a ?crit :
> >> On 2015-10-05 17:09, Peter Rosin wrote:

[...]

> Anyway, I find it unnecessarily hard to grasp exactly what you mean
> (wasteful policy you are apparently suffering from where it is OK to
> publish a patch written in English, but apparently a big no-no to
> send a diff until it passes some internal review???). I interpreted
> your "patch" in English as:
> 
>  		at91_twi_read_next_byte(dev);
> -	else if (irqstatus & AT_TWI_TXRDY)
> +	else if ((irqstatus & (AT91_TWI_TXCOMP | AT91_TWI_TXRDY | AT91_TWI_NACK)) == AT91_TWI_TXRDY)
>  		at91_twi_write_next_byte(dev);

We don't have such kind of policy. I simply discussed about your bug
with Cyrille and he managed to fix it. Since there are many
combinations (IP version, PIO/dma, hdmac/xdmac), I wanted to test it on
other platforms that the one used by Cyrille and add my signed-off-by
before sending it.

If nothing goes wrong (one platform has not been tested yet), the patch will
be sent this afternoon.

Cyrille answered in English in order to not create confusion with a patch which
could not fit all combinations.

Regards

Ludovic
