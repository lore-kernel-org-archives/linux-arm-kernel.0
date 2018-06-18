From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Jun 2018 01:28:58 -0700
Subject: Charge counter on droid 4
In-Reply-To: <20180618074023.GA16955@amd>
References: <20180615080014.GA29192@amd> <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com> <20180618074023.GA16955@amd>
Message-ID: <20180618082858.GO112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> 
> So... there are mA, mAh values. Those come from hardware, and I
> believe we should keep them.
> 
> But there are also mW, mWh values, which are synthetic. Userland can
> compute them from mV, mA values... and it is confusing that kernel
> provides them. (My tendency was to start computing these synthetic
> values in userland, to compare them with "real hardware" values from
> kernel. But then I looked at kernel implementation, and realized they
> are synthetic, tooo...)

Hmm mWh value is based on the hardware sampled shunt
values and number of samples gathered between the
two readings. I'd rather call the calculated values
based on userland reading mV and mA values "synthetic" :)

Regards,

Tony
