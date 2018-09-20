From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Sep 2018 00:48:18 +0200
Subject: [RFC PATCH 3/4] i2c: core: use I2C locking behaviour also for
 SMBUS
In-Reply-To: <e31d69ed-d849-db98-00c2-27d489a2dac1@axentia.se>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-4-wsa+renesas@sang-engineering.com>
 <e31d69ed-d849-db98-00c2-27d489a2dac1@axentia.se>
Message-ID: <20180920224818.GB988@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 07:31:19PM +0200, Peter Rosin wrote:
> On 2018-09-20 18:14, Wolfram Sang wrote:
> > If I2C transfers are executed in atomic contexts, trylock is used
> > instead of lock. This behaviour was missing for SMBUS, although a lot of
> > transfers are of SMBUS type, either emulated or direct. So, factor out
> > the locking routine into a helper and use it for I2C and SMBUS.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Is it ok with static analyzers to "hide" the locking in helpers like
> this? Will it not be harder for them to "see" what's going on? But I
> don't think we have any annotations anyway, so...

Yes, you are right. Yet, I prefer this to open coding the same twice and
have the problem to keep them in sync.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/d7ab1c6e/attachment.sig>
