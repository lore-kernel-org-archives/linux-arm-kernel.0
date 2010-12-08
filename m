From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 16:18:07 +0000
Subject: [RFC PATCH 06/13] picoxcell: add support for system clks
In-Reply-To: <1290506774-17895-7-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
	<1290506774-17895-7-git-send-email-jamie@jamieiles.com>
Message-ID: <20101208161807.GN9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 10:06:07AM +0000, Jamie Iles wrote:
> The different picoXcell device variants have different numbers of clocks
> and different capabilities (PC3X2 doesn't have any gateable or
> controllable clocks). Add the infrastructure necessary for device
> variants to provide their own clock implementation.

Fro the looks of this, you only allow one lookup per clk?  That's
rather sub-optimal, and could cause you problems in the future when
you may want to have aliases to cater for differences in the SoC
clock layout.
