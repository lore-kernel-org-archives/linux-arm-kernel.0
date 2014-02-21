From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 21 Feb 2014 19:51:51 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1725547.sbei6Aef3A@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <35719313.JyFlzSVKnx@wuerfel>
 <1392947251.15717.28.camel@deadeye.wl.decadent.org.uk>
 <1725547.sbei6Aef3A@wuerfel>
Message-ID: <1393012311.15717.52.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-21 at 14:07 +0100, Arnd Bergmann wrote:
> On Friday 21 February 2014 01:47:31 Ben Hutchings wrote:
> > On Thu, 2014-02-20 at 16:19 +0100, Arnd Bergmann wrote:
> > > On Thursday 20 February 2014 14:21:10 Ian Campbell wrote:
> >
> > > For all I know, the only interesting ixp4xx platforms are the consumer
> > > products listed on http://www.nslu2-linux.org/, the other ones you support
> > > are development boards that tend to exist only in very small quantities.
> > > 
> > > The main limitation would be the amount of installed RAM, which is
> > > either 32MB or 64MB depending on the machine for these. Running a
> > > modern Debian with these constraints is probably possible but
> > > doesn't sound like fun. 
> > 
> > Our most pressing constraint has actually been the size of the kernel
> > partition in flash, which is only ~1.4 MB on some of the iop32x and
> > ixp4xx machines (and ~1.5 MB on one of the orion5x machines).  We've
> > modularised as much as possible and turned off some of the features that
> > are otherwise standard across all Debian architectures.
> 
> Makes sense. I'm impressed you actually manage to get a modern kernel
> in 1.5MB and have it boot up a (mostly) full distro. I think we have
> in the past dropped a subarchitecture from the kernel when it turned
> out its defconfig could no longer fit within the 2MB of flash it
> has.
[...]

These are the changes we make for orion5x:

# CONFIG_KPROBES is not set
# CONFIG_CRYPTO_FIPS is not set
# CONFIG_VGA_ARB is not set
# CONFIG_AUDITSYSCALL is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
#. Saves about 17K, and none of the quirks are likely to be needed
# CONFIG_PCI_QUIRKS is not set
# CONFIG_FTRACE is not set
# CONFIG_KSM is not set
CONFIG_IPV6=m
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_RD_LZ4 is not set

For ixp4xx we have these as well:

#. Saves about 5K
# CONFIG_USER_NS is not set
#. Saves about 7K
# CONFIG_MEMCG is not set
#. Saves about 3K
# CONFIG_BPF_JIT is not set

(I think the built-in drivers for ixp4xx are smaller as well.)

Ben.

-- 
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/a367beee/attachment.sig>
