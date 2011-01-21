From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Fri, 21 Jan 2011 18:56:28 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <4D3935D2.4050307@codeaurora.org>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
	<20110120175551.GG6335@n2100.arm.linux.org.uk>
	<AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
	<4D3935D2.4050307@codeaurora.org>
Message-ID: <AANLkTinOjqgxf7zEhYM35iTrv9Eo_rq8feYaXrqjhAiR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/21 Saravana Kannan <skannan@codeaurora.org>:

[snip]

> The most likely scenario seems to be that the CPU freq driver that's
> specific to your CPU is not setting the CPU to the frequency it thinks it's
> setting it to. It might THINK it's running at 624 MHz, but it might really
> be at 310 MHz or 100 MHz or something. Since, if the frequency at which the
> calibration was done or if the new frequencies are not what really what they
> are reported to be, then the math will go wrong and you would see these kind
> of issues.

Yes, I'm thinking the same.

> If you can somehow measure your CPU freq with an oscilloscope, measure these
> two:
> - Just before calibrate_delay is run for the first time.
> - When you are seeing the udelay to be wrong.
>
> One of these two won't match what you think the CPU is running at.

The processor has an external 13 MHz crystal and the CPU frequency is
set by internal multipliers. I don't think the actual CPU clock (after
multipliers) is available on any of the chip pins. But thanks for the
tip.

Best regards,
Bj?rn Forsman
