From: eballetbo@gmail.com (=?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?=)
Date: Mon, 15 Nov 2010 09:32:22 +0100
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
	<20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
Message-ID: <AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2010/11/14 Marc Zyngier <maz@misterjones.org>:
> On Sun, 14 Nov 2010 19:11:46 +0100
> Enric Balletb? i Serra <eballetbo@gmail.com> wrote:
>
>> Why we need to define an unexistent regulator in board file ? This
>> should not be done enabling the CONFIG_DUMMY_REGULATOR in your kernel
>> configuration ??
>
> I'm not adding another regulator, but instead simply exposing the fact
> (or rather my guess) that the same regulator (vmmc1) is powering the
> two MMC channels. Not having access to the board schematics, I can't
> tell if that reflects the reality or not.
>
> But using CONFIG_DUMMY_REGULATOR seems the wrong idea to me, as it's
> just papering over the issue. We should be exposing what's really on
> the board (a fixed regulator if that's the case).

So the DUMMY_REGULATOR is only a workaround when a regulator is not
defined and shouldn't be used ? Sorry if this is a stupid question but
regulator interface is not too clear for me.

The reality is this :

 -------     --------
| 3V3 |   | 1V8 |
 -------    --------
    |          |
 -----------------
|   WIFI/BT  |
 -----------------
        | ( MMC2  at 1V8 )
 ----------------
|   OMAP   |
 ---------------

3V3 is a fixed regulator
1V8 is a fixed regulator (VIO from TWL4030)

So, which you think is the right solution ?

Cheers,
   Enric
