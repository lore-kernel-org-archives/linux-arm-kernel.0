From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 24 Apr 2016 22:39:23 +0200
Subject: [PATCH] i2c: designware-platdrv: get fast/std speed scl high/low
 count from DT
In-Reply-To: <20160413201147.5621a17c@xhacker>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
 <20160407175759.GO32257@rob-hp-laptop>
 <20160413201147.5621a17c@xhacker>
Message-ID: <20160424203922.GC4317@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 08:11:47PM +0800, Jisheng Zhang wrote:
> Dear Rob,
> 
> On Thu, 7 Apr 2016 12:57:59 -0500 Rob Herring wrote:
> 
> > On Wed, Apr 06, 2016 at 03:28:00PM +0800, Jisheng Zhang wrote:
> > > Sometimes, it's convenient to define the scl's high/low count directly,
> > > e.g HW people would do some measurement then directly give out the
> > > optimum counts. Previously, we solved the sda falling time and scl
> > > falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put them
> > > into dt, but what we really care isn't the sda/scl falling time.  
> > 
> > This is just so you can put specific clock count instead of converting 
> > from nanoseconds with standard properties or you gain some additional 
> > control of the timing. If only the former, then I prefer we stick with 
> > the common properties.
> 
> To be honest, both. Let me show how I gain additional control of the timing
> with this patch while I can't do this w/o it.
> 
> I want the similar high percent of SCL high for both standard-mode and
> fast-mode. Before this patch, this is not achievable because the parameters
> to cal the hcnt/lcnt via i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt() are different
> for standard-mode and fast-mode.

If there is something you can't describe currently, then we can add
additional properties to allow you to do what you want. But they should
be generic bindings and not a plain value which is custom to this driver.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160424/e39195df/attachment.sig>
