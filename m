From: slash.tmp@free.fr (Mason)
Date: Fri, 31 Jul 2015 17:13:09 +0200
Subject: Converting "board file" to device tree one device at a time?
In-Reply-To: <20150731150551.GW7557@n2100.arm.linux.org.uk>
References: <55BB4686.8030509@free.fr> <55BB8C08.1060006@free.fr>
 <20150731150551.GW7557@n2100.arm.linux.org.uk>
Message-ID: <55BB9085.8060200@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 17:05, Russell King - ARM Linux wrote:
> On Fri, Jul 31, 2015 at 04:54:00PM +0200, Mason wrote:
>> On 31/07/2015 11:57, Mason wrote:
>>
>>> Then I set a breakpoint in of_platform_serial_probe, hoping
>>> to witness the miracle... and nothing. Looks like device is
>>> never registered :-(
>>
>> IIUC, the kernel is supposed to parse my "uart0" node, and
>> register the device. Then the platform framework should see
>> that the node's "compatible" property is equal to one
>> advertized by the of_platform_serial_driver, and the kernel
>> should #!@& call of_platform_serial_probe? Right?!
> 
> No, it doesn't work like that.  The kernel creates platform devices
> from the nodes described in the DT file, which are then used to bind
> to the drivers in a very similar way to non-DT, except that if there's
> an dev->of_node pointer present, the compatible property is used.  If
> there are no devices being created from DT, drivers won't have anything
> to bind to.
> 
>> I just can't believe how much time I've been pulling my hair
>> over this trivial issue...
> 
> My /guess/ is that you have an .init_machine callback in place, but that
> is not calling of_platform_populate(NULL, of_default_bus_match_table,
> NULL, NULL); which means none of the DT-described devices are being
> created.

You are my savior.

Yes, I've read 5 bazillion OF/FDT tutorials/overviews, and I managed
to miss of_platform_populate. You have just saved this desk from one
more week of head-banging. Thanks again!

Regards.
