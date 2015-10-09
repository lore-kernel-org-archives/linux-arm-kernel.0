From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 12:28:09 +0200
Subject: [PATCHv3 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <1444384745.9895.265.camel@collabora.co.uk>
References: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
 <5551783.9EQ5GEjhxX@wuerfel> <1444384745.9895.265.camel@collabora.co.uk>
Message-ID: <5276113.A7SSumyVrv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 11:59:05 Sjoerd Simons wrote:
> 
> > I realize that building things as modules is a hassle, it is so for
> > some things more than for others, so I keep asking the question
> > to everyone to find out what a good balance is to make as much as
> > possible modules without hurting too much.
> 
> Fwiw, I don't find building modules overly cumbersome. Getting an
> initramfs capable of moving on to an NFS root is mostly a one-time
> thing (not unlike setting up the nfs root itself) and injecting modules
> into it is relatively simple (doubly so if taking advantage of the
> multiple cpio archive feature linux has). 
> 
> Interestingly, for me not building things as modules in multi_v7 tends
> to cause more work as it hides a few categories of bugs that tend to
> crop up once building distro kernels (e.g. missing module aliases,
> missing module device table entries, implicitly relying on clocks being
> active during probe as unused clocks only get turned of late in the
> init sequence etc).
> 

Ok, let's try to make all future network drivers modules in the
multi_v7_defconfig then, and get people to use an initramfs
if they need NFS root. If nobody complains too loudly for the
next few releases, we can change the existing drivers to =m as well.

	Arnd
