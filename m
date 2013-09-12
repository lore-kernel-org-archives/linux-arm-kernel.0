From: b32955@freescale.com (Huang Shijie)
Date: Thu, 12 Sep 2013 17:18:23 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130911113002.GP29403@sirena.org.uk>
References: <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
Message-ID: <523186DF.4070203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?11? 19:30, Mark Brown ??:
> Indeed - what I was wondering was if those opcodes could be requested
> from the flash driver rather than coded in there.  The driver needs to
> write the commands to the device but it's not clear to me if it really
> needs to know the specific commands.
yes. The driver uses the commands to find the _right_ LUT index, and
uses the LUT index to
trigger the controller.

For example, LUT0-LUT3 is used for the READ_STATUS, the driver will
match the
0 index for the NOR's read status operation (0x05), and then the driver
write 0 to the QSPI_IPCR
register to trigger the operation.

thanks
Huang Shijie
