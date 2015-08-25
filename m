From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Aug 2015 17:31:38 -0700
Subject: [PATCH v5 1/3] clk: bcm2835: Add binding docs for the Raspberry
 Pi clock provider
In-Reply-To: <1439507142-2965-2-git-send-email-eric@anholt.net>
References: <1439507142-2965-1-git-send-email-eric@anholt.net>
 <1439507142-2965-2-git-send-email-eric@anholt.net>
Message-ID: <87vbc4us2d.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> The hardware clocks are not controllable by the ARM, so we have to
> make requests to the firmware to do so from the VPU side.  This will
> let us replace fixed clocks in our DT with actual clock control (and
> correct frequency information).

Gordon from the Raspberry Pi Foundation just asked me "what do you mean,
you can't access the clocks from the ARM?"  I'd been assured I couldn't
by another developer (who was originally going to write a Linux driver
for this), and my own testing had also indicated I couldn't, but after a
new round of hacking together some tests, I see things that look a lot
like clockman registers.

Looks like we're going to get a native driver, instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150824/8ff89ce0/attachment.sig>
