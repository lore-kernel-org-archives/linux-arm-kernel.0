From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Mon, 13 Oct 2014 16:31:38 +0200
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <20141013142156.GE26864@lunn.ch>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <20141013142156.GE26864@lunn.ch>
Message-ID: <20141013143138.GJ1972@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling tx offload and disabling tx-nocache-copy, making the machine *send* a
lot of ssh traffic (sftp for example) makes ssh fail HMAC. It's quite easy to
reproduce here.

As for the hardware, it's an old sheevaplug board.

On Mon, Oct 13, 2014 at 04:21:56PM +0200, Andrew Lunn wrote:
> On Mon, Oct 13, 2014 at 12:52:46PM +0200, Llu?s Batlle i Rossell wrote:
> > Hello,
> > 
> > on the 7th of January 2014 ths patch was applied:
> > https://lkml.org/lkml/2014/1/7/307
> > 
> > [PATCH v2] net: Do not enable tx-nocache-copy by default
> >         
> > In the Sheevaplug (ARM Feroceon 88FR131 from Marvell) this made packets to be
> > sent corrupted. I think this machine has something special about the cache.
> 
> Hi Llu?s
> 
> Please could you describe your test setup. I would like to try to
> reproduce the problem. I have a machine based on kirkwood 6282 and the
> same ethernet.
> 
> Thanks
> 	Andrew
