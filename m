From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Oct 2014 15:57:16 +0200
Subject: [PATCH] spi/atmel: add support for runtime PM
In-Reply-To: <7hk33yhms4.fsf@deeprootsystems.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <7hk33yhms4.fsf@deeprootsystems.com>
Message-ID: <20141017135716.GS1820@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
> Wenyou Yang <wenyou.yang@atmel.com> writes:

> > +	if (!pm_runtime_suspended(dev)) {
> > +		clk_disable_unprepare(as->clk);
> > +		pinctrl_pm_select_sleep_state(dev);
> > +	}

> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback does
> the same thing.

Will that do the right thing when runtime PM is disabled in Kconfig?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141017/14622648/attachment-0001.sig>
