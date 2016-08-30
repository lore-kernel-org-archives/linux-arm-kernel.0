From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Aug 2016 16:15:32 +0200
Subject: [PATCH 2/2] clk: mvebu: dynamically allocate resources in
 Armada CP110 system controller
In-Reply-To: <1471933609-8456-3-git-send-email-mw@semihalf.com>
References: <1471933609-8456-1-git-send-email-mw@semihalf.com>
 <1471933609-8456-3-git-send-email-mw@semihalf.com>
Message-ID: <20160830161532.0770bdff@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 23 Aug 2016 08:26:49 +0200, Marcin Wojtas wrote:
> Original commit, which added support for Armada CP110 system controller
> used global variables for storing all clock information. It worked
> fine for Armada 7k SoC, with single CP110 block. After dual-CP110 Armada 8k
> was introduced, the data got overwritten and corrupted.
> 
> This patch fixes the issue by allocating resources dynamically in the
> driver probe and storing it as platform drvdata.
> 
> Fixes: d3da3eaef7f4 ("clk: mvebu: new driver for Armada CP110 system ...")

Adding:

CC: <stable@vger.kernel.org>

here would be useful.

> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Other than that:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 (on Armada 8K hardware)
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks a lot for fixing the crap that I initially wrote :-/

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
