From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 16:52:41 +0300
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821134936.GH7995@opensource.wolfsonmicro.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
Message-ID: <20120821135240.GJ10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 02:49:37PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:27:44PM +0300, Felipe Balbi wrote:
> 
> > I still beg to differ. Even if it fails, dmesg will still contain the
> > message (provided you have it enabled). I really don't think we want
> > this to print to console on every boot.
> 
> Only if it's enabled which is the trick...
> 
> > If you're still testing your new batch of boards, you're not just a
> > simple user and you will have debugging enabled anyway. dev_info() will
> > be visible to anyone who's got a console running. Not sure how useful
> > that would be to my neighbor.
> 
> Also think about hobbyists and so on, and ideally at some point the
> people using distros.  We shouldn't be requiring kernel rebuilds for
> this sort of diagnostic information.  I guess sysfs is another option

but we don't. We have dynamic printk for that, right ?

> but frankly the overhead on boot just doesn't seem meaningful in the
> context of the overall kernel boot style - I'd really expect people who
> are bothered by this sort of output would be raising the minimum log
> level appearing on the console.

Well, if you consider a single driver then surely it doesn't make a
difference. But when you add many drivers, each with its own dev_info()
output, it can delay bootup rather significantly, actually.

Fair enough, we have "quiet", but I'm not sure that's enough argument to
allow any simple driver to start poluting dmesg with whatever random
messages.

my 2 cents

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/38b14769/attachment.sig>
