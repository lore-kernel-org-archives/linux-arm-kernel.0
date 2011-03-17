From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 17 Mar 2011 10:07:18 +0000
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
In-Reply-To: <AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
	<AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
Message-ID: <1300356438.19700.23.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If your hardware engineers are listening, I suggest that hardware clock
> gating (as suggested in some earlier mail)

I've discussed this idea with our FPGA magician at the very beginning,
but for some reason we wasn't very happy about this... I can't really
blame him - it's not really his job to maintain individual components.
And the original cell authors are long time... em, not dead probably ;-)
just not available.

> plus DMA engine support will
> yet improve this by orders of magnitude and

Some of future test chips will have DMA330 (aka PL330), some won't. It's
all about size, and as most of those chips are some kind of ASIC or
semi-FPGA designs, the area is scarce...

>  also bring you less errors.

One thing is not to generate the errors, second thing is to handle them
correctly. And I must agree with Russell that error handling in the MMC
stack is far from ideal.

Cheers!

Pawe?
