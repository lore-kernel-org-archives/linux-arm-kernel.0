From: pekon@ti.com (Gupta, Pekon)
Date: Mon, 2 Dec 2013 11:01:53 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529C5BBF.6000604@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <529C5BBF.6000604@freescale.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA50789@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Huang Shijie [mailto:b32955 at freescale.com]
>Hi Angus:
>   thanks for the long suggestion. it's very useful.
>
>Let's push the spi nor framework.:)
> 
Yes, indeed nicely explained ..

[...]

>> 	int (*wait_till_ready)(struct spi_nor_info *info);
>
>currently, we poll the status register.
>why this hook is needed?
>
Currently there is no uniformity between different vendors to R/W Status
and Config registers. Also the layout and functionality of various fields in
Status and Config register vary from vendor to vendor. So, either you can
define this for-each vendor.. Or let each driver handle it separately.

[...]

>> 	int (*erase_sector)(struct spi_nor_info *info, off_t offs);
>I also confused at this hook.
>
>if we need erase_sector, do we still need the erase_chip()?
>
Yes, there are multiple types of erase commands..
(1) sector erase.
(2) block erase.
(3) bulk erase or chip erase.
Refer attachment ..


with regards, pekon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Serial_Flash_commands.png
Type: image/png
Size: 59763 bytes
Desc: Serial_Flash_commands.png
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/5f0ed78a/attachment-0001.png>
