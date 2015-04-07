From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 07 Apr 2015 13:37:01 +0200
Subject: [PATCH v2 0/4] arm: tegra: implement NVEC driver using tegrai2c.
In-Reply-To: <20150403194635.GC2016@katana>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana>
Message-ID: <1549160.njMIY2NVTi@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Am Freitag, 3. April 2015, 21:46:35 schrieb Wolfram Sang:
> On Mon, Mar 30, 2015 at 11:00:11PM +0300, Andrey Danin wrote:
> > NVEC driver contains code to manage tegra i2c controller in slave mode.
> > I2C slave support was implemented in linux kernel. The goal of this
> > patch serie is to implement I2C slave mode in tegra drived and rework
> > NVEC driver to use it.
> 
> Thanks. Looks pretty good already. If being I2C slave was the reason for
> this driver being in staging, we soon need to think of a proper place
> outside staging.

yes, moving the low level i2c functions out to the bus driver was our major 
concern. But there are still some minor things left before before we can move 
out of staging.

One thing where we need your help as a I2C maintainer is how to represent an 
i2c slave device using device-tree. You may remember our discussion in the 
past from here [1] where you suggested to just make a slave client by its 
compatible name. Stephen Warren from NVIDIA raised some concerns about this 
solution because it may not be appropriate in all possible future cases (which 
is what a proper device-tree representation should take care off). He instead 
suggested to mark a slave client by adding some flag to the reg property, to 
be able to handle a situation where both master client and slave client have 
the same i2c bus address forming a loopback (e.g. for testing purpose) on the 
same bus. More details here [2].

I hope with this post I can join the different discussions somehow so we are 
able to find a common sense which is acceptable for all.

Marc

[1] http://lkml.iu.edu/hypermail/linux/kernel/1409.1/03446.html
[2] https://lists.launchpad.net/ac100/msg01361.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/330e1c96/attachment.sig>
