From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Dec 2011 14:19:46 +0000
Subject: [PATCH] arm: add default value for PHYS_OFFSET Kconfig setting
In-Reply-To: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
References: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <201112011419.46751.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2011, Paul Gortmaker wrote:
> Commit 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef introduced the new
> Kconfig for PHYS_OFFSET but it did not specify a default value.
> 
> This has the undesired side effect of breaking an implictly used
> trick for updating defconfigs on the fly for routine buildtesting
> across all arch and all platforms, i.e.
> 
>   cp /path/to/somedefconfig .config ; yes "" | make oldconfig
> 

FWIW, a better way to achieve the above is using 

make KCONFIG_ALLCONFIG=/path/to/somedefconfig listnewconfig alldefconfig

which does not have this problem.

Your patch looks still ok, but you might want to update your scripts
to be more robust.

	Arnd
