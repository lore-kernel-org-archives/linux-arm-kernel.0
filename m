From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 29 Aug 2014 10:45:38 +0200
Subject: [PATCH RESEND 0/8] i2c: Relax mandatory I2C ID table passing
In-Reply-To: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140829084538.GC1329@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> Placing this firmly back on your plate.  I truly hope we don't miss
> another merge-window.

Nope, we won't. I'll still need a week or so due to other duties.

> This patch-set has the support of some pretty
> senior kernel maintainers, so I hope acceptance shouldn't be too
> difficult.

Cool, then they could ack it like Grant did? That surely helps.

> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.

I agree...

> The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.

... yet it also should not cause regressions. If you fixed that, sounds
great!

> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.

Even better :) I am generally positive with your patchset, but need to
review the implementation. For core stuff, this simply needs more
attention.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/d14b349c/attachment.sig>
