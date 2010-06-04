From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 4 Jun 2010 09:40:48 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100603110533.GB7127@n2100.arm.linux.org.uk>
References: <1275479804.137633.565764505843.0.gpush@pororo>
	<201006031824.53832.jeremy.kerr@canonical.com>
	<20100603110533.GB7127@n2100.arm.linux.org.uk>
Message-ID: <201006040940.51776.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Or to put it another way, the above method results in clk_enable()
> sometimes returning with the clock enabled and sometimes with the
> clock still disabled.
> 
> That's not nice behaviour for drivers which may need the clock enabled
> to read/write the device registers.

OK, I'll rework with proper locking to ensure that the clock is 
enabled/disabled on return from clk_enable.

Cheers,


Jeremy
