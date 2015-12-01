From: eric@anholt.net (Eric Anholt)
Date: Tue, 01 Dec 2015 15:16:20 -0800
Subject: [PATCH 2/3] pwm: bcm2835: prevent division by zero
In-Reply-To: <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
 <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87h9k1yd2z.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> It's possible that the pwm clock become an orphan. So better
> check the result of clk_get_rate in order to prevent a division
> by zero.

How would we lose our clock when we're keeping the clock enabled from
driver probe until remove?

Patches 1 and 3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/646cc66d/attachment.sig>
