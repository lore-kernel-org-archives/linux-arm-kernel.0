From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 30 Jul 2018 09:14:43 +0200
Subject: [PATCH v3 0/3] i2c: at91: slave mode support
In-Reply-To: <20180720224141.lawanibd7v4hmbym@ninjato>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
Message-ID: <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 12:41:41AM +0200, Wolfram Sang wrote:
> > [Ludovic Desroches]
> > Changes in v3:
> >  - rebase (cherry-pick was enough)
> 
> Thanks for the rebase. I wonder, though, I recall to had more
> complicated issues. However...
> 
> >  - fix checkpatch errors
> >  - tests:
> >    - hangs with a SAMA5D4 (master and slave on different busses) after about
> >    100 transfers. It's the firs time I do this test.
> >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> >    I don't know if it's a regression. I don't remember having seen this
> >    behavior previously.
> >    I think it's worth taking those patches even if there are some possible
> >    bugs. It'll allow to get more people using it and so to consolidate the
> >    slave mode support.
> 
> I really want to see those patches go upstream, too. But I am also not a
> big fan of delivering the user something with known issues. Especially
> not when they affect the main feature to be added. My rationale here is
> that someone who is able to fix the issues remaining will also be able
> to pick up and apply patches.
> 
> Maybe, maybe if it was to be enabled by a special
> I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> think twice about that, though.
> 

I understand your point. The experimental mentionning could be a good
trade-off. Let me know once you make up your mind.

> Speaking of Kconfig, I think this series needs to place a
> 
> 	select I2C_SLAVE
> 
> somewhere.
> 

Ok I'll update it if we go further with this set of patches.

Regards

Ludovic
