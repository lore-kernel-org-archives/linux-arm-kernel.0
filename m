From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 11 Aug 2013 23:19:23 +0100
Subject: [RFC PATCH] ARM: dma: default ZONE_DMA to y if ARM_LPAE
In-Reply-To: <CAOesGMgvU4Vxg1vwnvjUp3fEHbWDYc1mKTvCyaE4zQOfMr_2sw@mail.gmail.com>
References: <1374843951-1615-1-git-send-email-will.deacon@arm.com>
 <20130811215112.GB26757@quad.lixom.net>
 <20130811220541.GZ23006@n2100.arm.linux.org.uk>
 <CAOesGMgvU4Vxg1vwnvjUp3fEHbWDYc1mKTvCyaE4zQOfMr_2sw@mail.gmail.com>
Message-ID: <20130811221923.GA23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 03:14:26PM -0700, Olof Johansson wrote:
> On Sun, Aug 11, 2013 at 3:05 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > No.  As I keep telling people, go look at my dma-mask patches and stop
> > papering over this problem.
> 
> Ah, yes, I'm going through email backlog. The DMA mask series will
> definitely cover this in a better way.
> 
> This is a minimal patch that could be suitable for -stable backport.
> If we care about that -- I'm sure people can just amend their configs
> where needed.

Well, it's not a regression, it's something which has never worked.  In
my mind, that isn't really -stable material - stable is for stuff that
was either working and has been broken or for security stuff.

Having all your system memory above 4G _and_ having 32-bit DMA masks is
something which never worked.
