From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 14:04:59 +0000
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
Message-ID: <20111212140459.GX14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 07:03:48PM +0000, Pawel Moll wrote:
> If twd_base is not set, try to map the TWD registers from
> "arm,smp-twd" Device Tree node (compatible value as used in
> Highbank's DT).

Please do it the other way around - allow DT to override twd_base if
the DT node is present.

The propsed way gets in the way of the single zImage stuff which Linaro
is working on.
