From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Mar 2012 15:09:34 -0300
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator
 for the smsc911x device
In-Reply-To: <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5DL8YQT2qb=vxdQtdN+zfZLK9H9_1qu5sS+1YAvSo5SAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Sat, Mar 3, 2012 at 8:40 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

...
> ? ? ? ?/* Register Lan device on the debugboard */
> + ? ? ? regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));

I am using linux-next, which has this patch applied and I am getting:

smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
smsc911x smsc911x.0: (unregistered net_device): couldn't get regulators -517
platform smsc911x.0: Driver smsc911x requests probe deferral

Does this work for you on pcm037?

If I select CONFIG_REGULATOR_DUMMY then the the smsc driver is probed
correctly, but if I understand correctly your suggestion was to not
select CONFIG_REGULATOR_DUMMY, right?
