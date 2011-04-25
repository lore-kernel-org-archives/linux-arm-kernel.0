From: yanok@emcraft.com (Ilya Yanok)
Date: Mon, 25 Apr 2011 04:37:38 +0400
Subject: [RFC] What is the preferred way to share ADC unit between hwmon and
	input(ts) drivers?
Message-ID: <4DB4C252.30005@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

we are working with Freescale i.MX25 SoC which has the same register
space for ADC and touch-screen controller (AFAIK, that's pretty common
situation).
So, to add both input and hwmon drivers we need to serialize the
register accesses. I was thinking about adding some middle-layer to
perform the actual conversion. The question is what is the preferred way
to add such a middle layer? Should we use a multi-function device driver
for this or just some platform-specific code (as S3C does)? Or maybe
there is another way?
We hope to push our changes upstream so I'd like to know how such thing
is supposed to be implemented.

Thanks.

Regards, Ilya.
