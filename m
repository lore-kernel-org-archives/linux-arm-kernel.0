From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 6 Sep 2018 20:40:49 +0200
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
In-Reply-To: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180906184049.GF8607@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
> In most of cases, interrupt bits are set one by one but there are
> also a lot of other cases that Aspeed I2C IP sends multiple
> interrupt bits with combining master and slave events using a
> single interrupt call. It happens much more in multi-master
> environment than single-master. For an example, when master is
> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
> SLAVE_MATCH and RX_DONE interrupts could come along with the
> NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus. In this case, the NORMAL_STOP
> interrupt should be handled by master_irq and the SLAVE_MATCH and
> RX_DONE interrupts should be handled by slave_irq. This commit
> modifies irq hadling logic to handle the master/slave combined
> events properly.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/e639f9f3/attachment.sig>
