From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 1 Feb 2011 20:27:25 +0200
Subject: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc regulator
	constraints
In-Reply-To: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20110201202725.804aa011.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  1 Feb 2011 17:36:28 +0200
Aaro Koskinen <aaro.koskinen@nokia.com> wrote:

> With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage
> regulator setup will fail if there are voltage constraints defined. This
> made MMC unusable on this board. Fix by just deleting those redundant
> constraints.
> 
True. Before there were a test min_uV == max_uV && ops->set_voltage and
now min_uV == max_uV followed by test for ops->set_voltage that returns
EINVAL if not set (NULL for fixed voltage regulator obviously).

Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>
