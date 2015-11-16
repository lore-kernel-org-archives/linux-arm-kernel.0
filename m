From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 16 Nov 2015 19:46:05 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <20151116181718.GW8644@n2100.arm.linux.org.uk>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB056161DA1A57638A1D7305D58A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We don't need the data sections because they will have been copied to RAM, and
> we probably don't want to keep those exposed (it's potentially useful for
> attackers.)

The init sections also hang around after boot as well (it's XIP code, so there is nothing to 'free' in terms of executable init code).
Any potential security issues there as well? Should the data and init-text sections be put in a separate section that gets blown away after init-data is freed?

Chris
