From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 14:49:59 +0200
Subject: Why MSI is limited to 32 MSI's per device
In-Reply-To: <loom.20160615T083745-646@post.gmane.org>
References: <loom.20160614T164843-937@post.gmane.org>
 <20160614154507.GA14781@leverpostej>
 <loom.20160615T083745-646@post.gmane.org>
Message-ID: <8152156.hidk5yF9cg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 15, 2016 6:39:53 AM CEST valmiki wrote:
> Thanks a lot Mark.
> 
> I have one more doubt regarding MSI-X, why MSI-X table is maintained in end
> points bar memory, why cant it be maintained/allocated in host memory ?

Making the device do a DMA read to fetch the MSI-X descriptor every time it
wants to send an interrupt message would add a serious overhead to very
time-critical operation. I don't think this is something the PCI SIG would
have considered.

	Arnd
