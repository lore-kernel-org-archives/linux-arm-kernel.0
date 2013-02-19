From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 21:43:58 +0000
Subject: [GIT PULL] ARM: tegra: common clock framework fixes
In-Reply-To: <1360780358-2866-1-git-send-email-swarren@wwwdotorg.org>
References: <1360780358-2866-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201302192143.59019.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Stephen Warren wrote:
> A number of small fixes are included to the new Tegra common clock
> driver. These are: Missing locking, definition of device tree clock IDs
> not matching the binding, a static cleanup, missing initialization of
> some UART clocks.
> 
> This branch is based on Tegra's previous pull request tegra-for-3.9-dt.
> This dependency is caused by the one patch that edits the device tree.
> If this causes a problem, I can drop the final two patches in this pull
> request for now, and rebase it onto previous tegra-for-3.9-soc-ccf
> instead.

It's not ideal, but I've merged them into next/dt now because of this
dependency. The order of the next/* branches in arm-soc is fixed
now because of other dependencies, so putting it into next/soc would
have been equally wrong.

I think a better solution would have been to send two pull requests,
where one was based on the ccf branch and the other on the dt branch.

	Arnd
