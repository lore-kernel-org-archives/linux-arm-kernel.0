From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 26 Aug 2014 15:20:54 +0200
Subject: [PATCH v7 0/8] Per-user clock constraints
In-Reply-To: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5035317.536XV5BeWG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

Am Montag, 18. August 2014, 17:30:26 schrieb Tomeu Vizoso:
> Hi,
> 
> in this v7 of the patchset I have only rebased on top of 3.17rc1, with no
> other changes. I have had to do a fair amount of fixing due to the rebase,
> more details below. Follows the original cover letter blurb:
> 
> I'm retaking Rabin's patches [0] for splitting the clk API in two: one API
> for clk consumers and another for providers. The consumer API uses a clk
> structure that just keeps track of the consumer and has a reference to the
> actual clk_core struct, which is used internally.
> 
> I have kept a patch from Rabin that aims to aid in debugging nested
> enable/disable calls, though my personal aim is to allow more than one
> consumer to influence the final, effective frequency rate. For now this is
> limited to setting floor and ceiling constraints, with the short-term aim
> of allowing devfreq and thermal drivers to set floor and ceiling
> frequencies on the memory clock, respectively.

sounds interesting. I've tested your clk-refactoring-7 branch on a Rockchip 
rk3188-radxarock and rk3288-evb-rk808 board, so

Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
