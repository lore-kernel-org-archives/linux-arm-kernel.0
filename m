From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Sep 2014 09:54:36 -0700
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
In-Reply-To: <5414FD1F.6020603@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
 <20140913163749.GK7960@sirena.org.uk>
 <5414FD1F.6020603@rock-chips.com>
Message-ID: <20140915165436.GW7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 10:27:43AM +0800, Jianqun wrote:
> ? 09/14/2014 12:37 AM, Mark Brown ??:

> >> +	ret = clk_prepare_enable(i2s->hclk);
> >> +	if (ret) {
> >> +		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
> >> +		return ret;
> >> +	}

> > BTW: you're also missing a clk_disable_unprepare() in the remove path
> > here, please send a followup fixing that.
> remove function has done the clk_disable_unprepare for "hclk".

> One more thing, since "i2s_clk" is enabled at runtime_resume, and is disabled in runtime_suspend,
> hasn't enable in probe, so do the "i2s_clk" to be disabled in remove ?
> The current driver has disable in remove.

Again, please try to write clear changelogs which describe what the goal
of the patch is and cover obvious questions like this which a reviewer
might ask.

This is all extremely unclear - you're adding an enable here with no
matching disable.  It seems that what you saying that there was
previously a bug where the clock was disabled without being enabled?
I had to look at the code to work that out...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/4f25d2fa/attachment-0001.sig>
