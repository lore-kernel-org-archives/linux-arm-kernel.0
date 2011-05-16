From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 23:34:10 +0100
Subject: [PATCH 15/19] clocksource: ARM sp804: obtain sp804 timer rate
	via clks
In-Reply-To: <4DD1A2AD.4040004@gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1cq-0003ED-2X@rmk-PC.arm.linux.org.uk>
	<4DD1A2AD.4040004@gmail.com>
Message-ID: <20110516223410.GN13659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 05:18:21PM -0500, Rob Herring wrote:
> On 05/16/2011 12:30 PM, Russell King - ARM Linux wrote:
>> +	rate = clk_get_rate(clk);
>> +	if (rate<  0) {
>> +		pr_err("sp804: %s clock failed to get rate: %ld\n", name, err);
>
> err should be rate.

Yup, already spotted that and fixed.
