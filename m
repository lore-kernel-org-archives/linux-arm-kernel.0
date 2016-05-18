From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 18 May 2016 20:01:44 +0200
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <CAD=FV=UoT2GRYWJWXEn_ccvKGgC+PzQM_BCtLHAa7jxzbaQ9SA@mail.gmail.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <573C3283.1040606@rock-chips.com>
 <CAD=FV=UoT2GRYWJWXEn_ccvKGgC+PzQM_BCtLHAa7jxzbaQ9SA@mail.gmail.com>
Message-ID: <9061286.nTNVjb4bva@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 18. Mai 2016, 10:37:52 schrieb Doug Anderson:
> Note: I'd be very curious if your problems get better if you disable
> the "grf_force_jtag" bit in the GRF.  If you're using the builtin card
> detect and you use the boot default of "grf_force_jtag" then your pins
> will be unmuxed behind your back when the card is ejected.  This could
> be causing the dw_mmc controller to get confused.

On the rk3288, we saw issues with the jtag/sdmmc function and thus disabled 
that altogether in [0]. Not sure if that is a similar problem for you.

Heiko

[0] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c9b75d51c940c25587a2ad72ec7ec60490abfb6c
