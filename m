From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 17 Oct 2014 18:41:36 +0200
Subject: [PATCH v2 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <20141017163500.GJ22169@norris-Latitude-E6410>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043295.9388.82.camel@decadent.org.uk>
 <20141010045126.GB22169@norris-Latitude-E6410>
 <20141017162335.GG22169@norris-Latitude-E6410>
 <20141017163500.GJ22169@norris-Latitude-E6410>
Message-ID: <1413564096.23022.5.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-17 at 09:35 -0700, Brian Norris wrote:
> On Fri, Oct 17, 2014 at 09:23:35AM -0700, Brian Norris wrote:
> > On Thu, Oct 09, 2014 at 09:51:26PM -0700, Brian Norris wrote:
> > > On Tue, Sep 30, 2014 at 03:14:55AM +0100, Ben Hutchings wrote:
> > > > m25p80's device ID table is now spi_nor_ids, defined in spi-nor.  The
> > > > MODULE_DEVICE_TABLE() macro doesn't work with extern definitions, but
> > > > its use was also removed at the same time.  Now if m25p80 is built as
> > > > a module it doesn't get the necessary aliases to be loaded
> > > > automatically.
> > > > 
> > > > A clean solution to this will involve defining the list of device
> > > > IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> > > > API, but this is quite a large change.
> > > > 
> > > > As a quick fix suitable for stable, copy the device IDs back into
> > > > m25p80.
> > > > 
> > > > Fixes: 03e296f613af ("mtd: m25p80: use the SPI nor framework")
> > > > Cc: stable <stable@vger.kernel.org> # 3.16.x: 32f1b7c8352f: mtd: move support for struct flash_platform_data into m25p80
> > > > Cc: stable <stable@vger.kernel.org> # 3.16.x
> > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > 
> > > Can I get any acks/tested-by's? I'll try to test this out when I get
> > > back to the office, but I'd like to be able to send this in the 3.18
> > > cycle still.
> > 
> > Applied this patch to l2-mtd/master. Thanks!
> 
> Scratch that; I took Rafal's rebased version found at:
> 
>   git://git.infradead.org/users/rafal/mtd.git

Thanks!

Ben.

-- 
Ben Hutchings
Life is what happens to you while you're busy making other plans.
                                                               - John Lennon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141017/6fe4715f/attachment.sig>
