From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 14 Nov 2014 17:53:24 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141114073756.GA5336@amd>
References: <201411052137.31452@pali> <20141105203918.GA29199@amd>
 <201411052206.05379@pali> <20141105220359.GA32052@amd>
 <20141105234555.GA7097@earth.universe> <20141106124711.GA26944@amd>
 <20141106180335.GA21513@earth.universe>
 <20141113162155.GA8512@xo-6d-61-c0.localdomain>
 <20141113174534.GO26481@atomide.com> <20141114073756.GA5336@amd>
Message-ID: <20141114165324.GA12250@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 08:37:56AM +0100, Pavel Machek wrote:
> I'm using nfsroot (no modules), .config is attached. Debian v7.7,
> ofono installed.
> 
> To launch ofono, I'm using:
> 
> rmdir /dev/cmt
> ln -s /sys/bus/hsi/devices/n900-modem/ /dev/cmt

At least with Debian as base you can add this to your /etc/rc.local
and be happy, since the link will be created before ofono starts via
/etc/init.d/ ;)

I did not send ofono guys a patch to use
/sys/bus/hsi/devices/n900-modem/, since the kernel is supposed to
handle the PM, so there will be another, simpler interface (I plan
to use pm=2 for that).

> killall  ofonod
> sleep .1
> ofonod --nodetach --debug &

or just use "/etc/init.d/ofono restart". The above is mostly useful
for getting debug output from ofono.

> [...]

The short description for .config: CONFIG_NOKIA_MODEM must not be
disabled. It should depend on everything else needed:

CONFIG_PHONET
CONFIG_HSI
CONFIG_OMAP_SSI
CONFIG_OMAP_SSI_PORT
CONFIG_SSI_PROTOCOL
CONFIG_NOKIA_MODEM


-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/9e8497dc/attachment.sig>
