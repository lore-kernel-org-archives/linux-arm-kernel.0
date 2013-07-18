From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Jul 2013 11:45:29 -0700
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130718112555.GB1021@amd.pavel.ucw.cz>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org>
 <20130717213836.GA13324@amd.pavel.ucw.cz>
 <51E719A6.6070105@wwwdotorg.org>
 <20130718112555.GB1021@amd.pavel.ucw.cz>
Message-ID: <CAOesGMgi0j_mPyeBLVHb_QW+DwtAPoFY697eQO3-yp9tnP1vmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 18, 2013 at 4:25 AM, Pavel Machek <pavel@denx.de> wrote:

> It sound to me like keeping ammount of -EPROBE_DEFER to minimum is
> still preferred.

Hand-crafting initcall level ordering of various drivers and subsystem
is probably an even greater evil though. We've done it in the past,
but now that we have deferred probe we have the option of not having
to do it every time, such as this.

You're spending an awful lot of energy arguing over this, but nobody
has actually shown data of how much deferral is happening -- and that
it's a real problem. Until someone does so there's no reason to change
it from the default module init level at all, I'd say.


-Olof
