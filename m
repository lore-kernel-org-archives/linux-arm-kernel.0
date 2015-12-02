From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 2 Dec 2015 18:08:45 +0100
Subject: [PATCH 2/3] pwm: bcm2835: prevent division by zero
In-Reply-To: <87h9k1yd2z.fsf@eliezer.anholt.net>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
 <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
 <87h9k1yd2z.fsf@eliezer.anholt.net>
Message-ID: <565F259D.6060905@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.12.2015 um 00:16 schrieb Eric Anholt:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> It's possible that the pwm clock become an orphan. So better
>> check the result of clk_get_rate in order to prevent a division
>> by zero.
> How would we lose our clock when we're keeping the clock enabled from
> driver probe until remove?

It's not the problem that we lose the clock inside this driver. The pwm
clock could be initial assigned to a unregistered parent clock like "GND".

I'm refering to this discussion:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-November/002603.html

>
> Patches 1 and 3 are:
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
