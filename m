From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Sep 2010 10:31:04 +0100
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <87k4mcak6b.fsf@macbook.be.48ers.dk>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
Message-ID: <20100923093104.GA22397@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 11:22:36AM +0200, Peter Korsgaard wrote:
> >>>>> "Nicolas" == Nicolas Ferre <nicolas.ferre@atmel.com> writes:
> 
> Hi,
> 
>  Nicolas> By the way, I suspect that at91sam9g20 has the same issue
>  Nicolas> (400MHz core also)...
> 
>  Nicolas> We may also have a look at at91sam9g10 which embeds a 266MHz
>  Nicolas> core....
> 
> Yes, but I don't have access that hw, so it's hard to know exact udelay
> values. udelay=5 for 9g20 and udelay=3 for 9g10 probably aren't far off,
> but it would be nice if someone with hw could test.

udelay(5) should always give something approximating a 5us delay, as we
calibrate this delay loop against the system timer.  What I could believe
is probably going on here is that writing to the hardware is adding
additional delays - but that's nothing to do with the CPU speed itself.
