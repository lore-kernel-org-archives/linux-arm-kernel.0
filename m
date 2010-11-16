From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 16 Nov 2010 09:20:22 +0000
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
	<20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
	<AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
Message-ID: <20101116092022.7b4ea99f@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Nov 2010 09:32:22 +0100
Enric Balletb? i Serra <eballetbo@gmail.com> wrote:

Hi Enric,
> 
> So the DUMMY_REGULATOR is only a workaround when a regulator is not
> defined and shouldn't be used ? Sorry if this is a stupid question but
> regulator interface is not too clear for me.

My understanding is that DUMMY_REGULATOR kicks in when the regulator
setup is incomplete, and when it's better to fix things behind the
user's back rather than leaving him with a broken device.

> The reality is this :
> 
>  -------     --------
> | 3V3 |   | 1V8 |
>  -------    --------
>     |          |
>  -----------------
> |   WIFI/BT  |
>  -----------------
>         | ( MMC2  at 1V8 )
>  ----------------
> |   OMAP   |
>  ---------------
> 
> 3V3 is a fixed regulator
> 1V8 is a fixed regulator (VIO from TWL4030)
> 
> So, which you think is the right solution ?

I think we should provide a fixed regulator to the device, wired to
the .vio field of twl4030_platform_data. I'll submit a patch later
today, once I get a chance to test it on my board.

Cheers,

	M.
-- 
I'm the slime oozin' out from your TV set...
