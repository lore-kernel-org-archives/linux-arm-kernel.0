From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 22:34:34 +0100
Subject: [PATCH 17/19] clockevents: ARM sp804: obtain sp804 timer rate
	via clks
In-Reply-To: <4DD1960B.5000603@gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
	<4DD1960B.5000603@gmail.com>
Message-ID: <20110516213434.GK13659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 04:24:27PM -0500, Rob Herring wrote:
> On 05/16/2011 12:31 PM, Russell King - ARM Linux wrote:
>> -	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
>> +	evt->mult = div_sc(rate, SEC_PER_MSEC, evt->shift);
>
> This doesn't compile or make sense. Should be NSEC_PER_SEC.

Grr.  Fixed too.  No idea how that crap happened, but thanks for catching
it all.
