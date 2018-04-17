From: vigneshr@ti.com (Vignesh R)
Date: Tue, 17 Apr 2018 14:50:26 +0530
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180416154545.GA5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
Message-ID: <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
>> Hi,
>>
>> I'm not entirely sure what's going on, but I see corrupted characters
>> with the serial console on the OMAP4430 SDP board.  During boot,
>> everything seems fine, the problem appears to be userspace output.
>>
>> For example, if I edit a file, then quit vi:
>>
>> :q??%??B??Z?root at omap-4430sdp:~#
> 
> I don't think I've seen that one. What I've seen few times is
> typing a key on the serial console echoing back the previous
> character typed while the new character won't get displayed
> until hitting keyboard again. Only rebooting the device seems
> to solve this. This is with 4430 ES2.3 revision.
> 
> I wonder if we're missing some parts of errata i202 handling
> in omap_8250_mdr1_errataset()?
> 
> Also, I'm seeing an issue where the UARTs won't idle on init
> with 8250_omap driver if connected to the wl12xx bluetooth port
> unless I write some data to the port first. It does not seem
> to be related to the rts/cts lines being wired as I've tested
> muxing them out of the way.
> 

If this instance of UART is using DMA then it might be due an errata
worked around in AM33/AM43/DRA7:
https://patchwork.kernel.org/patch/6784331/


-- 
Regards
Vignesh
