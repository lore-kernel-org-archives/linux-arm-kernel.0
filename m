From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 11:28:22 +0000
Subject: [PATCH] dma: fix vchan_cookie_complete() debug print
In-Reply-To: <20140120095917.GZ26823@intel.com>
References: <1386344529-25617-1-git-send-email-jonas.jensen@gmail.com>
 <20140120095917.GZ26823@intel.com>
Message-ID: <20140120112822.GA15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 03:29:17PM +0530, Vinod Koul wrote:
> On Fri, Dec 06, 2013 at 04:42:09PM +0100, Jonas Jensen wrote:
> > vd->tx.cookie is set zero on dma_cookie_complete(),
> > save to local before printing it.
> > 
> > Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> > ---
> > 
> > Notes:
> >     dev_vdbg() could also be moved to happen earlier, what do you prefer?
> This would be preferred IMHO. Also pls cc dmaengine at vger on this

I prefer this version - it means that the verbose debug printk doesn't
impact the completion timing when printk is expensive (eg, because its
outputting via a serial port.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
