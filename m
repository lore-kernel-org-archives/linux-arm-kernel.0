From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 11 Sep 2014 16:49:39 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140911141257.GC5149@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2> <20140911141257.GC5149@katana>
Message-ID: <1848352.9OlbbQfLfy@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. September 2014, 16:12:58 schrieb Wolfram Sang:
> On Thu, Sep 11, 2014 at 02:17:16PM +0200, Marc Dietrich wrote:
> > > +		reg = <0x64>;
> > 
> > we had some discussions in the past how to represent i2c master devices in
> > device tree. The outcome was to use to a special representation to
> > distinguish them from slave devices, e.g. something like reg = <0x1
> > 0x64>, where the 0x1 would mean "master" device (0x0 -> slave). If
> > nothing is added, then it's also slave. The adapter address cell would
> > also need to be changed if this extension is used.
> 
> Please don't change the reg-layout which is around since forever.
> It will break all existing devicetrees. NAK.

it won't break existing device trees. It would only need to be extended for 
systems where the adapter uses master and slave modes (or if you add a master 
device to the i2c client list). So you need to change the device tree anyway.
All other setups can continue to use a single reg.

Thinking more about it, are there any i2c clients parsing the reg property 
directly? In this case I would agree, otherwise, only i2c core needs some 
update - right?

Marc

> > An alternative would be to use a special property (e.g. slave address),
> > but
> > that would encode the same value twice (or even three times).
> 
> As said, if all breaks we handle it at runtime.
> 
> Thanks,
> 
>    Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/6798445d/attachment.sig>
