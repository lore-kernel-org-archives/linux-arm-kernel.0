From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Mar 2017 21:01:36 +0000
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <4342694.H5cy8vaG9k@wuerfel>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <29393988.imklgXkpJX@wuerfel> <20160418152126.GA3154@localhost.localdomain>
 <4342694.H5cy8vaG9k@wuerfel>
Message-ID: <1489611696.4195.186.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-18 at 17:31 +0200, Arnd Bergmann wrote:
> On Monday 18 April 2016 20:51:27 Jerin Jacob wrote:
> > 
> > 
> > Why only to disable mmap() serivce in proc/bus/pci/*/*. Why not
> > other??services offered though proc/bus/pci/ like config space
> > read,
> > /proc/bus/pci/devices etc
> > 
> > if a given platform not interested in proc fs??then disable through
> > CONFIG_PROC_FS in defconfig. I don't understand the logic behind
> > disabling partial services that proc fs exposes.
> Disabling CONFIG_PROC_FS is not really an option for anybody.
> 
> The config space access may be something we should have disabled,
> or it may not be, but I think it's too late to kill that off now,
> as that would likely break something.
> 
> The mmap() support on those files is way uglier than the config
> access, so as long as nobody absolutely requires it, we should
> not add it to the list of things we can't get rid of again.

I don't think we should be doing this. You may have guessed that from
my... less than sympathetic... implementation of it in the patch I just
sent.

The thing is, this *isn't* an architecture-specific interface where you
get a clean slate. It's a cross-platform interface. Legacy and horrid,
sure. But it does you no harm.

What *else* don't you like having in /proc? Shall we have a clean slate
and eliminate *everything* other than actual processes from /proc for
the next architecture we add to the tree? If not, why not?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/6a3ba016/attachment-0001.bin>
