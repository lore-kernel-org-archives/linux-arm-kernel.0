From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Dec 2017 11:38:48 +0000
Subject: Linux Kernel handling AXI DECERR/SLVERR
In-Reply-To: <BLUPR0201MB150517EAFAF3A46B8A19489CA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A278D2EF1EABD80555EEA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20171219104500.5otagp7m7dqretd2@lakrids.cambridge.arm.com>
 <BLUPR0201MB150517EAFAF3A46B8A19489CA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <20171219113848.6dpb3fosbznguala@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 11:28:49AM +0000, Bharat Kumar Gogada wrote:
> In our case the peripheral returns SLVERR first time and we see the following print but kernel do not hang.
> [  231.484186] Unhandled fault: synchronous external abort (0x92000210) at 0x0000007f9241f880
> Bus error
> 
> And from simulation we know that subsequent access to peripheral
> returns OKAY response, however we see subsequent access fail with same
> above bus error when we boot Linux.
> 
> Is there a way to handle these synchronous abort gracefully in Linux
> or are these fatal ?

We don't currently have any mechanism to handle these, though it might
be possible for synchronous aborts.

Do you know why the device is returning SLVERR in this case?

Thanks,
Mark.
