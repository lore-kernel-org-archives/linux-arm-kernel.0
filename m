From: eric@anholt.net (Eric Anholt)
Date: Fri, 08 Apr 2016 13:05:06 -0700
Subject: [PATCH 2/2] clk: bcm2835: Fix PLL poweron
In-Reply-To: <1945341121.176536.ed7e19c8-94d6-4e1c-b383-3e4ae025eeac.open-xchange@email.1und1.de>
References: <1459826456-18812-1-git-send-email-eric@anholt.net>
 <1459826456-18812-3-git-send-email-eric@anholt.net>
 <1945341121.176536.ed7e19c8-94d6-4e1c-b383-3e4ae025eeac.open-xchange@email.1und1.de>
Message-ID: <87lh4nzx1p.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 5. April 2016 um 05:20 geschrieben:
>>
>>
>> In poweroff, we set the reset bit and the power down bit, but only
>> managed to unset the reset bit for poweron. This meant that if HDMI
>> did -EPROBE_DEFER after it had grabbed its clocks, we'd power down the
>> PLLH (that had been on at boot time) and never recover.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Cc: stable at vger.kernel.org
>
> please provide a Fixes tag.
>
> Thanks Stefan

That should be:

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160408/65ee536a/attachment.sig>
