From: slash.tmp@free.fr (Mason)
Date: Fri, 31 Jul 2015 18:17:11 +0200
Subject: Converting "board file" to device tree one device at a time?
In-Reply-To: <20150731150551.GW7557@n2100.arm.linux.org.uk>
References: <55BB4686.8030509@free.fr> <55BB8C08.1060006@free.fr>
 <20150731150551.GW7557@n2100.arm.linux.org.uk>
Message-ID: <55BB9F87.2050307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 17:05, Russell King - ARM Linux wrote:

> My /guess/ is that you have an .init_machine callback in place, but that
> is not calling of_platform_populate(NULL, of_default_bus_match_table,
> NULL, NULL); which means none of the DT-described devices are being
> created.

You guessed right. Thanks again!

One more question, if I may.

I deleted the .init_machine callback, but the board init
function was still being called!

MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
  ...
  //.init_machine = tangox_87xx_board_init,
MACHINE_END

I suspected it might be called directly from elsewhere,
and launched grep:

  arch_initcall(tangox_init_devices);

I suppose the arch_initcall macro registers the function
to be called at some point during init?

Then this means that, before I commented the .init_machine
callback, the function was being called twice?

Once through .init_machine and once through arch_initcall?

Regards.
