From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:45 +0000
Subject: [GIT PULL] mx5 merge
In-Reply-To: <20111116075053.GG27267@pengutronix.de>
References: <20111116075053.GG27267@pengutronix.de>
Message-ID: <201111232115.45313.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2011, Sascha Hauer wrote:
> Please pull the following branch which merges the mx5 architecture into
> mach-imx. As said before, I'd love to get this into this -rc cycle
> because we would get unnecessary merge conflicts later. Anyway, if you
> think that this is a really bad idea please pull it for next.
> 
> Sascha
> 
> The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:
> 
>   Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git mx5-merge

Hi Sascha,

I've pulled it into the imx/move branch, to be merged through the next/move
branch in arm-soc now.

Sorry for not replying earlier. I think the best plan is to do it at the
end of a merge window, but I didn't feel comfortable at the end of the
3.2-rc1 because I had not seen the patches before.

Since almost all the files are trivially moved, I think we can best avoid
all merge conflicts by applying the move changeset last after all other
changes to mx5 code have gone in. I'll gladly take care of regenerating
the patch before I send it (and letting you double-check the result).

However, what I'd like you to do is minimize the changes that don't
just move entire files around by submitting them as a cleanup branch
that I can apply *before* all other patches. I think we should have
separate patches for these changes:

* merge mach-mx5/system.c into pm-imx5.c
* merge arch/arm/mach-mx5/Kconfig into arch/arm/mach-imx/Kconfig
* ARM i.MX5: remove unnecessary includes from board files

If we do these early, the remaining move will be even more trivial
than the current series.

	Arnd
