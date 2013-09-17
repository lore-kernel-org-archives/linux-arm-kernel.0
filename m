From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Sep 2013 11:51:42 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <5237BB01.3080700@freescale.com>
References: <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com>
 <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com>
 <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com>
 <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com>
 <20130916110634.GC29403@sirena.org.uk>
 <5237BB01.3080700@freescale.com>
Message-ID: <20130917105142.GO21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 10:14:25AM +0800, Huang Shijie wrote:

> The dummy is just a delay in a command sequence.
> The dummy maybe only several clock cycles, less then 8 bit.

This is what the delay_usecs field in the spi_transfer struct is for,
the flash code should be using that to ensure that the minimum delay
requirement is met.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/51efd757/attachment.sig>
