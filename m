From: klightspeed@killerwolves.net (Ben Peddell)
Date: Mon, 27 Oct 2014 03:42:42 +1000
Subject: [PATCHv0] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <544CB246.2030607@killerwolves.net>
References: <3d0cc6de9ea5506d5fb201129ad277e57d0cdfc8.1414268057.git.arno@natisbad.org>
 <20141025221611.GA14620@lunn.ch> <544CB246.2030607@killerwolves.net>
Message-ID: <544D3292.4090805@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/14 18:35, Ben Peddell wrote:
> On 26/10/14 08:16, Andrew Lunn wrote:
>> What does seem odd is the Reboot, FIS, etc, mtd partition names. 
>> Is there redboot installed at all?
> 
> I think the RedBoot partition names are carried over from the older
> PPC-based Synology DiskStations.  As far as I can tell, the FIS 
> directory partition is never referenced by the Synology kernel or
> bootloader, though the information in it does match what is used by
> the kernel, and it appears it may be used by the Synology updater.

I stand corrected here - on the Marvell Armada XP and Armada 370
DiskStations, the FIS directory (RedBoot parts) does appear to be
used by the Synology kernel.

If I'm reading it right, unless otherwise configured, the RedBoot
partition maps will take precedence over the device tree partition 
maps when CONFIG_MTD_REDBOOT_PARTS is enabled.
