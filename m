From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 10:56:58 -0700
Subject: [PATCH v4 1/8] clk: bcm2835: Add binding docs for the Raspberry
 Pi clock provider
In-Reply-To: <20150811211840.31346.28666@quantum>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
 <1437420787-32137-2-git-send-email-eric@anholt.net>
 <20150811211840.31346.28666@quantum>
Message-ID: <87zj1w4cgl.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@linaro.org> writes:

> Quoting Eric Anholt (2015-07-20 12:33:00)
>> The hardware clocks are not controllable by the ARM, so we have to
>> make requests to the firmware to do so from the VPU side.  This will
>> let us replace fixed clocks in our DT with actual clock control (and
>> correct frequency information).
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>> Acked-by: Lee Jones <lee@kernel.org>
>
> Looks good to me. Do you want the clk patches to go through the clk tree
> or do you want them all together? For this patch feel free to add:
>
> Acked-by: Michael Turquette <mturquette@baylibre.com>

It would be nice to do them all together in the arm-soc tree, since the
later DT changes require that the clock driver be present.  (And, since
this is a dependency of the RPi2 work, it would let us stack that on
top, too).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0d1a7c0d/attachment-0001.sig>
