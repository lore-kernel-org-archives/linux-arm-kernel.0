From: klightspeed@killerwolves.net (Ben Peddell)
Date: Thu, 09 Jan 2014 15:18:35 +1000
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
Message-ID: <52CE312B.3060108@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 09:47, Andrew Lunn wrote:
> Request for Testing:
> 
> This patch adds support for around 30 different boards. Most .dts
> files support a couple of different models. I don't have any of this
> hardware. None of this is tested.

Tested by Ben Peddell <klightspeed@killerwolves.net> (specifically kirkwood-ds210.dts on DS211j)

To get running on the stock bootloader, I needed to extend the 
initramfs to fill the entire rd.gz flash partition, configure the 
kernel to use the dtb appended to it, configure it to ignore the 
information passed to it by the bootloader, and add the following 
nodes to the dts:

/chosen {
	linux,initrd-start = <0x800040>;
	linux,initrd-end   = <0x940000>;
};
