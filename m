From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Feb 2011 15:52:38 -0800
Subject: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc
	regulator constraints
In-Reply-To: <20110201202725.804aa011.jhnikula@gmail.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
	<20110201202725.804aa011.jhnikula@gmail.com>
Message-ID: <20110201235238.GK3358@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110201 10:26]:
> On Tue,  1 Feb 2011 17:36:28 +0200
> Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> 
> > With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage
> > regulator setup will fail if there are voltage constraints defined. This
> > made MMC unusable on this board. Fix by just deleting those redundant
> > constraints.
> > 
> True. Before there were a test min_uV == max_uV && ops->set_voltage and
> now min_uV == max_uV followed by test for ops->set_voltage that returns
> EINVAL if not set (NULL for fixed voltage regulator obviously).
> 
> Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks adding into devel-fixes.

Tony
