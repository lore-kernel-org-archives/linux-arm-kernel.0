From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 29 Jun 2012 02:29:31 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <CAN1soZwwWhNC2pQjwYz-jUjNrnnPfshyPQJL-8uM6z6BKvCwMA@mail.gmail.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de>
 <20120628114616.GE28922@opensource.wolfsonmicro.com>
 <201206281432.24061.arnd@arndb.de>
 <CAN1soZwwWhNC2pQjwYz-jUjNrnnPfshyPQJL-8uM6z6BKvCwMA@mail.gmail.com>
Message-ID: <20120629012930.GM28922@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 09:18:07AM +0800, Haojian Zhuang wrote:
> On Thu, Jun 28, 2012 at 10:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > But it would be very helpful to see how the platform data is set, especially
> > with the callback. If the callback is just there to set up a regulator
> > or clock, then it should be changed to a more generic way.

> No, the callbacks is not used to set up a regulator or clock. They're used to
> configure the logic that are not integrated into drivers yet. For example, one
> special regulator needs active in sleep mode; some power saving configuration

This is a *totally* normal pattern for PMICs, normally the things that
are being configured by Linux would be configured prior to Linux
starting and the callback is basically there for overriding things so we
can fix up mistakes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/bd351af7/attachment.sig>
