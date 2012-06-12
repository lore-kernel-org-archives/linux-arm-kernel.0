From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 15:18:21 -0700
Subject: [PATCH] clk: Check parent for NULL in clk_change_rate
In-Reply-To: <1339160646-32664-1-git-send-email-pawel.moll@arm.com>
References: <1339160646-32664-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20120612221821.GJ19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120608-14:04, Pawel Moll wrote:
> clk_change_rate() is accessing parent's rate without checking
> if the parent exists at all. In case of root clocks this will
> cause NULL pointer dereference.
> 
> This patch follows what clk_calc_new_rates() does in such
> situation.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Pawel,

This problem is indeed a real one.  I've taken your patch into clk-next
for testing.

Thanks much,
Mike
