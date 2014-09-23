From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Sep 2014 22:03:39 -0700
Subject: [PATCH] ARM: mach-bcm: offer a new maintainer and process
In-Reply-To: <1411150632-25695-1-git-send-email-f.fainelli@gmail.com>
References: <1411150632-25695-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140923050339.GF7487@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 11:17:11AM -0700, Florian Fainelli wrote:
> Hi all,
> 
> As some of you may have seen in the news, Broadcom has recently stopped
> its mobile SoC activities. Upstream support for Broadcom's Mobile SoCs
> was an effort initially started by Christian Daudt and his team, and then
> continued by Alex Eleder and Matter Porter assigned to a particular landing
> team within Linaro to help Broadcom doing so.
> 
> As part of this effort, Christian and Matt volunteered for centralizing pull
> requests coming from the arch/arm/mach-bcm/* directory and as of today, they
> are still responsible for merging mach-bcm pull requests coming from brcmstb,
> bcm5301x, bcm2835 and bcm63xx, creating an intermediate layer to the arm-soc
> tree.
> 
> Following the mobile group shut down, our group (in which Brian, Gregory, Marc,
> Kevin and myself are) inherited these mobile SoC platforms, although at this
> point we cannot comment on the future of mobile platforms, we know that our
> Linaro activities have been stopped.
> 
> We have not heard much from Christian and Matt in a while, and some of our pull
> requests have been stalling as a result. We would like to offer both a new
> maintainer for the mobile platforms as well as reworking the pull request
> process:
> 
> - our group has now full access to these platforms, putting us in the best
>   position to support Mobile SoCs questions

So, one question I have is whether it makes sense to keep the mobile
platforms in the kernel if the line of business is ending?

While I truly do appreciate the work done by Matt and others, there's
also little chance that it'll see substantial use by anyone. The Capri
boards aren't common out in the wild and I'm not aware of any dev
boards or consumer products with these SoCs that might want to run
mainline? Critical things such as power management and graphics are
missing from the current platform support in the kernel, so nobody is
likely to want it on their Android phone, etc.

Maybe the answer to this is "keep it for now, revisit sometime later",
which is perfectly sane -- it has practically no cost to keep it around
the way it's looking now.


-Olof
