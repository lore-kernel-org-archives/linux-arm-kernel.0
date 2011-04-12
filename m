From: cjb@laptop.org (Chris Ball)
Date: Tue, 12 Apr 2011 17:39:26 -0400
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <m3fwpnxj1w.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Tue, 12 Apr 2011 17:21:15 -0400")
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
	<20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
	<m3fwpnxj1w.fsf@pullcord.laptop.org>
Message-ID: <m37hazxi7l.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 12 2011, Chris Ball wrote:
> There aren't many -EOPNOTSUPP returns in the stack.  I see:
>
> card/block.c: mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq
> card/core.c: mmc_erase
> core/sd_ops.c: mmc_app_cmd
>
> Mind doing some instrumentation to figure out which it is?

Actually, this probably isn't necessary -- mmc_app_cmd() is the only call
involved in the setup path, via mmc_sd_init_card() -> mmc_app_send_scr().

So, a better question: was mmc_app_send_scr() succeeding on your previous
kernels?  There hasn't been much change in this area lately.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
