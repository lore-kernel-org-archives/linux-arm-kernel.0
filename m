From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 08 Jun 2013 09:57:17 +0100
Subject: Arm sub architectures missing clk_round_rate()
Message-ID: <51B2F1ED.2090801@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least one Arm subarch (pxa) does no provide an implementation of this
function.  As far as I can see there is no way for a driver wishing to use
it to detect it's absence.  This is marked in clk.h as being optional
for 'Machine Class support'. Obvious solutions to this are:

1) It is effectively only usable by platform specific drivers as no
   more generic driver can know it is available.  Perhaps even a stub that
   returns an appropriate error would be acceptable.

2) It is not as optional as the header implies and should always be implemented
   if the rest of the clk framework is.

3) There should be some means of detecting its absense so that drivers can
   be dependant on its presene.

Which is the correct one?

This issue came up as a result of the thread
http://marc.info/?l=linux-iio&m=137026653516438&w=2
[PATCH RESEND V2 3/4] iio: frequency: adf4350: Add support for clock consumer framework
on linux-iio at vger.kernel.org


Thanks,

Jonathan
