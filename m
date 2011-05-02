From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 02 May 2011 11:40:32 +0800
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <4DBE2064.2060303@gmail.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
	<4DBE2064.2060303@gmail.com>
Message-ID: <1304307632.2686.33.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> I think you will find many examples in the kernel where that is not done 
> by drivers.

Drivers should be checking the return value of clk_get - if they don't,
it's a bug. This is the logical place to check, rather than before all
clock API calls.

For cases where there is no clock provided for the device (but is a
valid clock on some machines), the platform code should return a no-op
clock from the clk_get call. This 'noop clock' would be a good contender
for inclusion into the kernel-wide infrastructure, like clk_fixed.

Cheers,


Jeremy
