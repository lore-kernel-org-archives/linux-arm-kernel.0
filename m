From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 5 Aug 2015 20:22:20 +0200
Subject: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
In-Reply-To: <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150805182220.GC11315@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 11:39:54AM +0200, Alexandre Belloni wrote:
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
> 
> Get and use the slow clock as it is necessary for the at91 reset
> controller.

You call clk_prepare_enable during probe without a matching
clk_disable_unprepare on module removal.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/c9c0c0ac/attachment.sig>
