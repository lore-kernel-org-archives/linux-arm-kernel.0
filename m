From: eric@anholt.net (Eric Anholt)
Date: Wed, 02 Dec 2015 11:43:39 -0800
Subject: [PATCH 2/3] pwm: bcm2835: prevent division by zero
In-Reply-To: <565F259D.6060905@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
 <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
 <87h9k1yd2z.fsf@eliezer.anholt.net> <565F259D.6060905@i2se.com>
Message-ID: <87lh9c8wlw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Am 02.12.2015 um 00:16 schrieb Eric Anholt:
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> It's possible that the pwm clock become an orphan. So better
>>> check the result of clk_get_rate in order to prevent a division
>>> by zero.
>> How would we lose our clock when we're keeping the clock enabled from
>> driver probe until remove?
>
> It's not the problem that we lose the clock inside this driver. The pwm
> clock could be initial assigned to a unregistered parent clock like "GND".
>
> I'm refering to this discussion:
>
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-November/002603.html

I actually would have expected that the prepare would error out on a
clock with no rate set.  Interesting.  This seems like a good safety
measure, so this one is also:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/dd15c55a/attachment.sig>
