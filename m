From: eddie.huang@mediatek.com (eddie huang)
Date: Mon, 3 Nov 2014 10:27:11 +0800
Subject: [PATCH RESEND] tty: serial: 8250_mtk: Fix quot calculation
In-Reply-To: <9001280.dDNTE2ykLV@wuerfel>
References: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
 <9001280.dDNTE2ykLV@wuerfel>
Message-ID: <1414981632.23623.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-31 at 17:48 +0100, Arnd Bergmann wrote:
> On Friday 31 October 2014 17:36:35 Matthias Brugger wrote:
> > -               quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
> > +               quot = (port->uartclk / (256 * baud)) + 1;
> 
> Should this be DIV_ROUND_UP then?
> 
> 	Arnd
> 

I think DIV_ROUND_UP is more suitable in this case, and I already do
this and test OK on my MTK platform

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296149.html
