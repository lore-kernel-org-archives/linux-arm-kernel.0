From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jul 2015 17:46:06 +0100
Subject: Converting "board file" to device tree one device at a time?
In-Reply-To: <55BB9F87.2050307@free.fr>
References: <55BB4686.8030509@free.fr> <55BB8C08.1060006@free.fr>
 <20150731150551.GW7557@n2100.arm.linux.org.uk>
 <55BB9F87.2050307@free.fr>
Message-ID: <20150731164605.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:17:11PM +0200, Mason wrote:
> On 31/07/2015 17:05, Russell King - ARM Linux wrote:
> 
> > My /guess/ is that you have an .init_machine callback in place, but that
> > is not calling of_platform_populate(NULL, of_default_bus_match_table,
> > NULL, NULL); which means none of the DT-described devices are being
> > created.
> 
> You guessed right. Thanks again!
> 
> One more question, if I may.
> 
> I deleted the .init_machine callback, but the board init
> function was still being called!
> 
> MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
>   ...
>   //.init_machine = tangox_87xx_board_init,
> MACHINE_END
> 
> I suspected it might be called directly from elsewhere,
> and launched grep:
> 
>   arch_initcall(tangox_init_devices);

Looks like different function names to me.  Not being able to see the
code you're modifying means I can't comment.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
