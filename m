From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Oct 2015 06:04:45 +0200
Subject: Using CONFIG_ARM_APPENDED_DTB with multiple device trees
In-Reply-To: <fce90e91fe3c452b80bcd2113f267003@svr-chch-ex1.atlnz.lc>
References: <fce90e91fe3c452b80bcd2113f267003@svr-chch-ex1.atlnz.lc>
Message-ID: <20151020040445.GA4478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 03:27:15AM +0000, Chris Packham wrote:
> Hi,
> 
> We currently have several boards based around the 88f6281 (kirkwood) ARM 
> CPU.
> 
> The boards all share a kernel image (currently 3.16 based but we're in 
> the process of moving to 4.3). We use the machine id (and some other 
> eeprom type information) to distinguish the boards.
> 
> We'd like to move to a device tree based model but we're restricted in 
> that updating the bootloaders to a DT-aware u-boot is impractical. 
> CONFIG_ARM_APPENDED_DTB allows us to append a device tree but we still 
> need to account for the differences between the boards.

Hi Chris

You might want to look at what Debian does. When installing the
kernel, it appends the correct DT blob depending on what the current
running kernel is, to the new kernel image before writing it to the
boot medium.

Another option is the pxa-impedance-matcher.

     Andrew
