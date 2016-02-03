From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 17:05:07 +0000
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <87egct4trb.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <20160202182842.GD29778@leverpostej>
 <87egct4trb.fsf@free-electrons.com>
Message-ID: <20160203170506.GE1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:56:56PM +0100, Gregory CLEMENT wrote:
> Hi Mark,
>  
>  On mar., f?vr. 02 2016, Mark Rutland <mark.rutland@arm.com> wrote:
> >> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> >> index 87d40a72f6a1..198f6bd56e84 100644
> >> --- a/Documentation/kernel-parameters.txt
> >> +++ b/Documentation/kernel-parameters.txt
> >> @@ -1058,6 +1058,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >>  			A valid base address must be provided, and the serial
> >>  			port must already be setup and configured.
> >>  
> >> +		mvebu_uart,<addr>
> >> +			Start an early, polled-mode console on an some mvebu
> >> +			SoC (as the Armada-3700) serial port at the specified
> >> +			address. The serial port must already be setup and
> >> +			configured. Options are not yet supported.
> >> +
> >
> > Does the the mvebu UART vary between platforms at all?
> 
> I am not sure to undersatnd your question.
> 
> If you asked about the UART used on the other mvebu SoCs then my answer
> is: on all the other mvebu SoC until now third party IPs were used.

Ah, I hadn't realised that.

> This one is the first one dedicated to an mevbu SoC and currently only
> used on Armada 3700 but I don't know what are the plan for the future
> mvebu SoCs.

Given that, I think it would be better to use "armada3700_uart=" for
now, given it doesn't cover all mvebu SoCs.

Thanks,
Mark.
