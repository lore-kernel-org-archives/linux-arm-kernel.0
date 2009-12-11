From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 11 Dec 2009 14:47:06 +0100
Subject: [samsung-soc] CPUfreq Linux clock API question
Message-ID: <000b01ca7a68$6d5f4cb0$481de610$%majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm working on providing cpufreq functionality for S5PC110 Samsung SoC.
For this purpose I'm using clock API's clk_set_rate function. All the code
is very similar to the one from S3C64xx.
Using standard clock API I've managed to control only the ARM core clock
frequency (and reduce chip power consumption in this way).

After some studies I've concluded that it would be welcome to change rate
(to be precise clock dividers values) for two clock simultaneously. It could
provide opportunities for further power savings. 

The clock API used at S3C64xx seems not to allow for setting rate of two
clocks simultaneously (or am I wrong? :-) ). 

If this change would not be possible, then have anyone thought about the way
to provide such functionality? 

It is always possible to "hack" the kernel clock API and provide new
pointers to new methods in the struck clk (and implement those new methods).
However I'm concerned if this "new" code would be accepted by the open
source community. 

As a good programming practice, I'd like to use already implemented and
tested API.

Sharing any experience in designing/programming kernel clock API will be
appreciated :-)

Best regards,
Lukasz Majewski

Samsung R&D Center, Poland
