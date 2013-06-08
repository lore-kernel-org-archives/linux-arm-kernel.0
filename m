From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jun 2013 10:21:33 +0100
Subject: Arm sub architectures missing clk_round_rate()
In-Reply-To: <51B2F1ED.2090801@kernel.org>
References: <51B2F1ED.2090801@kernel.org>
Message-ID: <20130608092133.GI18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 09:57:17AM +0100, Jonathan Cameron wrote:
> At least one Arm subarch (pxa) does no provide an implementation of this
> function.  As far as I can see there is no way for a driver wishing to use
> it to detect it's absence.  This is marked in clk.h as being optional
> for 'Machine Class support'. Obvious solutions to this are:
> 
> 1) It is effectively only usable by platform specific drivers as no
>    more generic driver can know it is available.  Perhaps even a stub that
>    returns an appropriate error would be acceptable.
> 
> 2) It is not as optional as the header implies and should always be implemented
>    if the rest of the clk framework is.
> 
> 3) There should be some means of detecting its absense so that drivers can
>    be dependant on its presene.
> 
> Which is the correct one?

The right answer is (2) now that we have things like the clk framework and
soo many users.
