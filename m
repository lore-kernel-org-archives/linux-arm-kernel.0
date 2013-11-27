From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Nov 2013 14:54:39 +0530
Subject: [PATCH] ARM: davinci: clock: return 0 upon error from
 clk_round_rate()
In-Reply-To: <alpine.DEB.2.02.1311261653510.11450@tamien>
References: <alpine.DEB.2.02.1311261653510.11450@tamien>
Message-ID: <5295BA57.7000708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 06:26 AM, Paul Walmsley wrote:
> 
> clk_round_rate() should return 0 now upon an error, rather than
> returning a negative error code.  This is because clk_round_rate() is
> being changed to return an unsigned return type rather than a signed
> type, since some clock sources can generate rates higher than (2^31)-1 Hz.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Philip Avinash <avinashphilip@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

I applied this to my v3.14/soc[1] branch. For some reason I could not
apply the patch to v3.11-rc1 (patch command returns error). Nothing is
obviously worng. Anyway, the change is minor so I made the change manually.

Thanks,
Sekhar

[1]
https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.14/soc
