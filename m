From: maz@misterjones.org (Marc Zyngier)
Date: Sun, 14 Nov 2010 18:52:07 +0000
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
Message-ID: <20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Nov 2010 19:11:46 +0100
Enric Balletb? i Serra <eballetbo@gmail.com> wrote:

> Why we need to define an unexistent regulator in board file ? This
> should not be done enabling the CONFIG_DUMMY_REGULATOR in your kernel
> configuration  ?

I'm not adding another regulator, but instead simply exposing the fact
(or rather my guess) that the same regulator (vmmc1) is powering the
two MMC channels. Not having access to the board schematics, I can't
tell if that reflects the reality or not.

But using CONFIG_DUMMY_REGULATOR seems the wrong idea to me, as it's
just papering over the issue. We should be exposing what's really on
the board (a fixed regulator if that's the case).

	M.
-- 
I'm the slime oozin' out from your TV set...
