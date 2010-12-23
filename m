From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 Dec 2010 10:25:49 +0900
Subject: [PATCH] rfc v3: ARM: mach-shmobile: mackerel: Add zboot support
In-Reply-To: <20101222230450.GA21134@verge.net.au>
References: <1291855635-30882-1-git-send-email-horms@verge.net.au>
	<20101222224901.GA16187@verge.net.au>
	<20101222230450.GA21134@verge.net.au>
Message-ID: <20101223012549.GA20530@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 08:04:51AM +0900, Simon Horman wrote:
> On Thu, Dec 23, 2010 at 07:49:01AM +0900, Simon Horman wrote:
> > On Thu, Dec 09, 2010 at 09:47:15AM +0900, Simon Horman wrote:
> > > When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
> > > boot loader and may be burned to rom or flash.
> > > 
> > > Compile tested only.
> > 
> > I now have access to a Mackerel board and have verified that
> > this patch works.
> > 
> > My verification method was to usa a hack; I removed the
> > SDRAM initialisation portion of head-mackerel.txt and
> > then booting the resulting zImage from uboot using:
> > 
> > => bootp
> > => go 0x42000000
> > 
> > This is the same method that I used to test the AP4 variant of this change.
> > 
> > Morimoto-san, could you test this by burning an image (without the above
> > hack) to Flash? I can provide an image or tree if that helps.
> 
> I have now verified the .txt file by booting from the MMCIF
> hardware block using "[PATCH] rfc v1: ARM: mach-shmobile: mackerel: Add
> zboot MMCIF support".
> 
> Paul, I think that it should be pretty safe to merge both this patch and
> the "... MMCIF support" patch into your tree from a feature point of view.
> I'm unsure what you want to do about dependencies.

Actually, the LED code in "rfc v1: ARM: mach-shmobile: mackerel: Add zboot
MMCIF support" is bogus - I can see that now that I have a mackerel to test.
I will post a fixed version shortly.
