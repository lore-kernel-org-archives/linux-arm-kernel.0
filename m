From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 14 Mar 2012 16:30:47 +0800
Subject: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
In-Reply-To: <4F604F9F.1070801@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-6-git-send-email-b29396@freescale.com>
 <4F604F9F.1070801@freescale.com>
Message-ID: <20120314083046.GD1180@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 03:58:23PM +0800, Huang Shijie-B32955 wrote:
> Hi,
> > +			dma-apbh at 80004000 {
> > +				compatible = "fsl,mxs-dma-apbh";
> > +				reg =<0x80004000 2000>;
> > +			};
> > +
> Why you do not add the `interrupt` for the it?
> the gpmi-nand needs to parse the interrupt out.
> 
The non-dt way also does not have interrupt resource for dma device.
It seems the channel interrupt resource is handled in each client device.
I'm not familiar with gpmi-nand, but I guess you may need to handle
it in gpmi driver, just like mxs-mmc driver.

Regards
Dong Aisheng
