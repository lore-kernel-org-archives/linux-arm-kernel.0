From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 9 Jan 2016 23:44:44 +0100
Subject: Nokia N900: u-SD card in v4.2+
In-Reply-To: <20160107113408.GA26618@amd>
References: <20160106204627.GA21477@amd> <568DFA4B.7030308@ti.com>
 <20160107113408.GA26618@amd>
Message-ID: <201601092344.44641@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 January 2016 12:34:09 Pavel Machek wrote:
> Hi!
> 
> > On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> > > Hi!
> > > 
> > > In v4.1, both internal MMC and u-SD cards work ok.
> > > 
> > > In v4.2, only the internal MMC is detected. In v4.3, not even
> > > internal MMC works. In v4.4, only the internal MMC is detected.
> > > 
> > > Does it work for you? Any patches?
> > 
> > I don't have Nokia N900 to check this, but can you share your
> > config and kernel logs? Check if CONFIG_REGULATOR_PBIAS is present
> > in your config. CONFIG_REGULATOR_PBIAS is now mandatory for all
> > omap3+ SoCs to work.
> 
> I enabled CONFIG_REGULATOR_PBIAS and both MMCs now work.
> 
> I wonder if we should add some selects, so that users updating from
> old kernels don't break their system?

Please add these selects. I had CONFIG_REGULATOR_PBIAS disabled too, 
because I just updated defconfig from older kernel version.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160109/20371783/attachment-0001.sig>
