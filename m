From: mporter@linaro.org (Matt Porter)
Date: Thu, 17 Apr 2014 18:26:16 -0400
Subject: [PATCH 2/4] mfd: bcm590xx: add support for second i2c slave
 address space
In-Reply-To: <20140417065753.GC28725@lee--X1>
References: <1397501428-8857-1-git-send-email-mporter@linaro.org>
 <1397501428-8857-3-git-send-email-mporter@linaro.org>
 <20140416110603.GA19671@lee--X1>
 <20140416213141.GD12304@sirena.org.uk>
 <20140417065753.GC28725@lee--X1>
Message-ID: <20140417222616.GK23695@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 07:57:53AM +0100, Lee Jones wrote:
> > > s/regmap/Regmap
> > 
> > It's consistently written regmap in all the documentation and so on :)
> 
> Furry muff; but the comments still stand for the acronyms.
> 
> > > addmap{0,1} doesn't quite sit right with me.
> > 
> > > REVISIT: Ah, it's address-map, rather than add map. Okay, not as bad
> > > as I first thought, but still, is there a better naming convention you
> > > could use?
> > 
> > addrmap or something?
> 
> Right, that was what I was thinking. However, I prefer something along
> the lines of 'i2c' and 'i2c_sec' or 'client' and 'client_slv' etc.

FWIW, the reason it's addmap{0,1} is that the datasheet has documents
ADDMAP=0 and the first bank of registers and ADDMAP=1 as the second bank
of registers. I adopted that to match the docs for the part.

I guess we could do i2c and i2c_sec, I'll just have to put a comment
correlating it to the h/w. Calling it 'slv' implies something else
so we should avoid that here. The notion of a "secondary" i2c device
is completely a Linux I2C subsystem fabrication which wouldn't exist
if it allowed multiple slave addresses per device. From a h/w
perspective there is really no primary and secondary relationship.

I'm fine with i2c/i2c_sec or addrmap0/1 and I will just comment to
correlate with the datasheet..pick one.

-Matt
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
