From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 09:57:39 +0100
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20150716085739.GT11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 07:27:34AM +0000, Ranjit Abhimanyu Waghmode wrote:

> For an example take two flashes connected in stacked mode.
> For user it doesn't matter whether how many flashes are really connected. 
> There will be situation like, single partition is spread across two flashes (partition staring at the end of one flash and continued to the second flash). But it has to be shown contiguous to user.
> In this scenario, I am not clear how MTD layer will handle the case.
> It would be great if you could just put some light on it.

That's something for the MTD layer or possibly even a layer above it to
worry about - this situation is the same as we have with disks where we
have md which combines other devices, if something similar is needed for
flash we should use a similar pattern.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/46121986/attachment.sig>
