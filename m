From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 15:24:14 -0400
Subject: [ANNOUNCE] mvebu tree move
Message-ID: <20130725192414.GS23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

We have set up a group tree for the mvebu maintainers to collaboratively
break. ;-)  The new tree can be found at:

  git://git.infradead.org/linux-mvebu.git

The old tree has been cleaned up a bit and will not be used for mainlining
work.

While I have your attention, here's a quick breakdown of the branch
layout:

# patches for -stable trees, branches are based on a common ancestor, eg
# v3.10 for stable-3.10.x

  mvebu/stable-*

# patches for the current merge window (currently, v3.11-rcX)

  mvebu/fixes

# patches the next merge window (currently v3.12)

  mvebu/fixes-non-critical
  mvebu/cleanup
  mvebu/drivers
  mvebu/soc
  mvebu/boards
  mvebu/defconfig
  mvebu/dt

# a merge of all mvebu/* branches for pulling into linux-next for
# testing.  ** rebased frequently **

  for-next

wrt to stability of branches, mvebu/* branches can be considered stable
up to *signed* tags we have sent PRs for.  Once a branch is pulled into
arm-soc it *can't* be changed because that will cause heartache and
discontent in linux-next between mvebu and arm-soc.

Thanks to David Woodhouse for setting this up on git.infradead.org for
us.

thx,

Jason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/8ee3d578/attachment.sig>
