From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 22:48:01 +0200
Subject: [GIT PULL] ux500-core for 3.2
In-Reply-To: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
References: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
Message-ID: <201109202248.01993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Linus Walleij wrote:
> could you please pull:
> 
> git://git.linaro.org/people/triad/linux-stericsson.git for-arnd
> 
> to the ARM SoC tree (ux500 branch or however you prefer to handle it)?
> They have all been reviewed on the ARM list recently and are mostly
> minor fixes and Lee Jones nice cleanup patch.

I would really like to see this split into logical branches, even
if there are just a few patches for each of them. It looks like
the series currently contains bug fixes and cleanups mixed together,
which makes it hard to backport fixes and for me to aggregate patches
across soc families by category.

It's also not clear if the two bug fix patches should be applied
to 3.1 and -stable as well as 3.2. My feeling is that they should.
If you want bug fixes to be backported, please add a 'Cc: stable at kernel.org'
line after your Signed-off-by. If not, add an explanation to the
pull request why they are not relevant for backporting.

I've applied the first four patches to the stericsson/cleanup
and next/cleanup branches now, since these look like they are
purely cleanup branches without noticeable code changes.

Please submit the two bug fixes again, rebased to an -rc release.
there is a dependency on one of the cleanup patches. Don't worry
about that, I'll take care of resolving this conflict after you
have rebased the bug fix to the mainline kernel.

Thanks,

	Arnd
