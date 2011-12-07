From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Dec 2011 15:06:19 +0000
Subject: subarch maintainers: please send 3.3 pull requests for arm-soc
Message-ID: <201112071506.19230.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Let me first say I'm very happy with the bug fixes I received for the 3.2
cycle. I'm about to send another bunch of those upstream now, and it's
good to see how everyone is now placing the stable tags in the patches
where necessary. I've been a bit slow in sending them out for -rc3/rc4
after I returned from a lot of traveling and it was very good that
Olof could handle the fixes for -rc2 before that.

However, looking at the for-next branch in arm-soc, we have very few
patches in total (thanks again to those of you who sumitted 3.3
stuff already):

~/linux-arm$ git branch
  at91/gpio
  at91/ioremap
  drivers/macb-gem
  drivers/macb-gem-cleanup
  drivers/pxa-gpio
  imx/move
  msm/misc
  msm/timer
  mxs/saif
  fixes
  for-next
~/linux-arm$ git log --oneline --no-merges fixes..for-next | wc -l
66

We are close to -rc5 now, so I would hope to have the majority of the
patches that are coming for 3.3 in there by now. I realize that there
is a lot of stuff that everyone is still working on, but there has
to be more than this that you are happy to go into arm-soc already.
Don't worry too much about bugs you are still looking for. All patches
that are reviewed, ready to go into linux-next, and don't need to
be rebased any more should go into arm-soc already.

As usual, please split the pull requests into separate branches
based on the type (bug fix, cleanup, new feature) and type of
change (driver, board, soc, platform, ...). When you have
interdependencies between the branches (e.g. a new feature depending
on a cleanup), send one pull request for each branch and describe
explictly why there is a dependency and in which order the pull
requests should go. In the more common case that there are conflicts
between branches (e.g. two branches doing similar but independent
changes to the same file), base all conflicting branches on the same
-rc release and let us resolve the conflict in arm-soc. Sascha likes
to provide a merge changeset for reference. This is very much
appreciated for any complex merges, but in most simple cases it's
not necessary.
If you have dependencies or known conflicts with branches that don't
go into arm-soc (e.g. Russell's ARM tree or Grant's DT tree), we
can handle that, too, by importing the dependency as a separate
branch into arm-soc and delaying the submission of your branch
until the other one was merged, but you need to make sure that
the branch you import does not get rebased any more, and you must
not just cherry-pick patches from another branch.

Finally, please address any arm-soc pull requests to both Olof
and me, as we are sharing the load for 3.3. I have handled all
pull requests since 3.2-rc2, but I expect things to get more
busy between now and the merge window, so we should be prepared
to split the work.

	Arnd
