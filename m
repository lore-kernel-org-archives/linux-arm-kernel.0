From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Oct 2012 14:54:19 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
Message-ID: <20121030125419.GG29095@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 12:50:52PM +0000, Paul Walmsley wrote:
> On Tue, 30 Oct 2012, Felipe Balbi wrote:
> 
> > the wmb() patch should help, but you said it doesn't, right ?
> 
> Correct.  Not sure why you think that would help; the problem is almost 

because of how the driver is behaving...

The only way for omap_i2c_wait_for_bb() to timeout is if the bus is
really still busy; meaning that either transfer hasn't fully completed
(some data still in FIFO), or we didn't send STOP or Repeated START
condition on the bus.

> certainly PM-idle related, given that the problem goes away by reverting 
> Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert 
> I2C driver to PM QoS for MPU latency constraints".
> 
> The problem is consistent and easy to reproduce here.

I don't doubt that :-) What I think, however, is that PM QoS just made
the problem a bit easier to trigger for whatever reason. Maybe because
pm qos defers constraint updates, or something similar ?

> > without seeing debugging information on the failing case, it'll be very
> > difficult to sort this one out provided noone else seems to be able to
> > reproduce it.
> 
> Aaro sees it also, so it's definitely not a local artifact.

Again I don't doubt it.

> It's not very surprising that the problem doesn't appear with the extra 
> logging enabled, since the extra logging presumably keeps the system out 
> of idle.  
> 
> Anyway, you are welcome to the userspace, bootloader, and X-loader here if 
> you would like to try to reproduce it.  They've been sent to Jean and 
> Kevin and Shubhrajyoti already.  Simply request it and I will send links.

I can have a look, sure, but I don't have the same platform as you have.
I have a beagle XM revB (according to the stickers on the board) which I
could use to try to reproduce, if I manage to, then hooray :-)

In that case, please give me also a link to your uImage so I can make
sure to use the exact same setup.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/14ae2ba0/attachment.sig>
