From: w@1wt.eu (Willy Tarreau)
Date: Thu, 10 Apr 2014 19:10:00 +0200
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410181953.50ccfcc3@skate>
References: <20140410181953.50ccfcc3@skate>
Message-ID: <20140410171000.GF25890@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Apr 10, 2014 at 06:19:53PM +0200, Thomas Petazzoni wrote:
> Hello all,
> 
> This is an e-mail that attempts to summarize the situation in terms of
> Armada XP PCIe issues.
> 
> At
> https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.14/pci-debug,
> I've pushed a branch based on top of v3.14 that contains:

Thanks for putting all this online.

I have a minor comment below :

>  * 2 patches on the pci-mvebu driver. One from Willy Tarreau to fix the
>    off by one on the sizes. And another one from me which splits the
>    PCI BAR into power-of-two sized chunks, in order to create valid
>    MBus windows.

As suggested by Jason, this one should be merged before his that's just
before, to ensure that it will not cause a regression.

> I've tested this with my IGB card which needs a 9 MB
>    BAR (so 8 MB + 1 MB needed), and I've also faked the code to code to
>    simulate a 11.5 MB BAR (so 8 + 2 + 1 + 0.5 MB), and it worked. I
>    also checked that if we have an error when creating one of the
>    windows, then all the previous windows needed for the current BAR
>    are properly removed.

Really cool, I'm going to test that on a few PCIe cards and will report
the results here. How can we check the number of mbus windows in use ?

Thanks,
Willy
