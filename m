From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 15:45:35 +0200
Subject: [PATCH] net: mvpp2: do not bypass the mvpp22_port_mii_set function
In-Reply-To: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
References: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
Message-ID: <20170606154535.3e87bafb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue,  6 Jun 2017 15:36:15 +0200, Antoine Tenart wrote:
> The mvpp22_port_mii_set() function was added by 2697582144dd, but the
> function directly returns without doing anything. This return was used
> when debugging and wasn't removed before sending the patch. Fix this.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Please add:

Fixes: 2697582144dd ("net: mvpp2: handle misc PPv2.1/PPv2.2 differences")

with this:

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I am wondering if we shouldn't Cc: stable as well. I don't think we
have seen issues on our side because U-Boot does the necessary
initialization, but people using other bootloaders might have issues.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
