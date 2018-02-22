From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Feb 2018 22:42:37 +0100
Subject: [v2,1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
Message-ID: <20180222214237.GH28112@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 06:45:51PM +0100, Stefan Hellermann wrote:
> Hi!
> 
> My QNAP TS-209 NAS Device is crashing with the following commit, which went
> in the kernel as commit 4904dbda41c860fd117b20f3c48adb2780eee37e
> 
> I cannot provide a boot log, the device panics before enabling the serial
> console.

Hi Stefan

Did you try earlyprintk? You might need to recompile your kernel to
enable it.

Looking at the code, i don't see anything obviously wrong. So i think
i would start by looking how many times it goes through the loop in
qnap_tsx09_find_mac_addr() with this patch reverted, and what address
it finds the MAC address at.

Then see what happens with the current crashing code. Is it failing to
recognise the MAC address, and so keep looping around?

Thanks
	Andrew
