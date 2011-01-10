From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 10 Jan 2011 13:44:25 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294528551.4181.19.camel@heimdal.trondhjem.org>
References: <20110105210448.GM8638@n2100.arm.linux.org.uk>	
	<AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com>	
	<1294262208.2952.4.camel@heimdal.trondhjem.org>	
	<AANLkTi=3Gu-rz=-OdNtUXn4qw60Df6=YePnzvB=s-+Ov@mail.gmail.com>	
	<1294268808.2952.18.camel@heimdal.trondhjem.org>	
	<1294270104.16957.73.camel@mulgrave.site>	
	<1294335614.22825.154.camel@mulgrave.site>	
	<1294336054.2905.1.camel@heimdal.trondhjem.org>	
	<AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>	
	<1294426405.2929.23.camel@heimdal.trondhjem.org>	
	<20110107190229.GX31708@n2100.arm.linux.org.uk>	
	<1294427467.4895.66.camel@mulgrave.site>	
	<1294505384.4181.14.camel@heimdal.trondhjem.org>
	<1294528551.4181.19.camel@heimdal.trondhjem.org>
Message-ID: <4D2AFF29.4060008@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2011 12:15 AM, Trond Myklebust wrote:
> From 8b2e60cef5c65eef41ab61286f62dec6bfb1ac27 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <Trond.Myklebust@netapp.com>
> Date: Sat, 8 Jan 2011 17:45:38 -0500
> Subject: [PATCH] NFS: Don't use vm_map_ram() in readdir
> 
> vm_map_ram() is not available on NOMMU platforms, and causes trouble
> on incoherrent architectures such as ARM when we access the page data
> through both the direct and the virtual mapping.
> 
> The alternative is to use the direct mapping to access page data
> for the case when we are not crossing a page boundary, but to copy
> the data into a linear scratch buffer when we are accessing data
> that spans page boundaries.
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

..on AT91 (armv5)

regards, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110110/f1fdce67/attachment.sig>
