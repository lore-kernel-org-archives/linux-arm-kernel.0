From: cjb@laptop.org (Chris Ball)
Date: Wed, 06 Jun 2012 09:48:46 -0400
Subject: [PATCH] mmc: omap: Fix broken reg_shift initialization
In-Reply-To: <20120530071300.GH12766@atomide.com> (Tony Lindgren's message of
 "Wed, 30 May 2012 00:13:01 -0700")
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
 <20120529125024.GM9577@arwen.pp.htv.fi>
 <20120529130312.GE12766@atomide.com>
 <20120530071300.GH12766@atomide.com>
Message-ID: <8762b44kld.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30 2012, Tony Lindgren wrote:
> Commit fa550189 (mmc: core: Prevent eMMC VCC supply to be cut from late init)
> slightly affected timings for how things are done for the omap MMC driver
> causing the MMC cards not getting detected any longer.
>
> Turns out this was caused by buggy reg_shift initialization in the omap
> MMC driver that was happening after mmc_add_host() was being called.
>
> Fix this by initializing reg_shift before mmc_add_host() is called.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> Heh found it! Chris, maybe Cc stable on this one?

Thanks, pushed to mmc-next for 3.5 with a stable@ tag added.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
