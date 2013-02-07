From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 22:44:51 +0000
Subject: [PATCH 0/4] Improve CLKSRC_OF matching
In-Reply-To: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
Message-ID: <201302072244.51588.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In the recently added support for OF based clocksource init, a device node
> will be matched twice. We can fix this by passing the device node to the
> init functions and removing the match functions within the init functions.
> 
> This is based on arm-soc for-next branch and commit "of: fix incorrect
> return value of of_find_matching_node_and_match()" in my DT for-next
> branch.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Conceptually this is definitely the way to go, but I noticed that
you create build warnings for the bisection points after the
first patch. I would suggest actually merging the first three
patches into one and also changing the prototype for the tegra
function in that patch to avoid this.

	Arnd
