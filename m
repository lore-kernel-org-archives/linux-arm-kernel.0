From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Aug 2013 14:08:18 -0600
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130806200256.GB19280@titan.lakedaemon.net>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806200256.GB19280@titan.lakedaemon.net>
Message-ID: <520157B2.8080205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 02:02 PM, Jason Cooper wrote:
> Thomas,
> 
> In order to get some testing in -next, I've *tentatively* applied this
> series in the following way:
> 
> +---+ mvebu/msi_common (1,2,3,10)
>     |
>     +---+---+ mvebu/msi_irq (4-9)
>             |
>             +---+---+ mvebu/msi_mvebu (11-13)
> 
> I had to make one change to patch #9, I protected the last two blocks
> with #ifdef CONFIG_PCI_MSI to prevent a build failure at that point.
> 
> mvebu/msi_common should be appropriate for Thierry to base off, however,
> I make no guarantees about the stability of the branch until I send a
> PR for it.  Code-wise, it should be fine, but the commit-ids may change
> due to adding Tested-by's, etc.

When do you intend to send the pull-request? I need a stable branch
before I can even apply Thierry's changes, and I'd prefer to get those
changes applied and in linux-next well before I send my pull requests to
arm-soc. At the very latest, I need enough time to apply Thierry's
patches on top of your final version of that branch, get it briefly
tested, and then send a pull-request to arm-soc before -rc6 is out, so
if your pull request goes in just before -rc6, that's going to be a problem.
