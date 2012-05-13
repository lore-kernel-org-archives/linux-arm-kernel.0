From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 May 2012 23:29:24 -0700
Subject: [GIT PULL] Renesas ARM-based platforms: new boards support for
 v3.5
In-Reply-To: <201205122323.14967.rjw@sisk.pl>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
 <201205122307.20590.rjw@sisk.pl> <201205122323.14967.rjw@sisk.pl>
Message-ID: <CAOesGMj5op-U+-_dvP_cqMUQ7zgzbzvig2ueb2LQTf+4MSEc2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 2:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>
> ? ?Linux 3.4-rc6
>
> with top-most commit a515be1ca7df947db0f6018a174f49507affcdbc
>
> ? ?Merge branch 'renesas-kzm9g' into renesas-board-new
>
> from the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board-new
>
> to receive updates of the Renesas ARM-based boards support code for v3.5.
> Included are:
>
> ?* Support for the KZM-A9-GT board from Kuninori Morimoto.
>
> ?* Support for the armadillo800eva board from Kuninori Morimoto.
>
> This is based on the Renesas core SoC code updates I've sent a separate pull
> request for.


Hi Rafael and Magnus,

I know Renesas is very active in adding support for new ARM platforms
upstream, and that's great. But we also need to figure out how it can
best be done while still keeping a bound on platform complexity.

This adds two new board files and two new defconfigs to the arm
subtree. We have in general said that we are OK with the occasional
new board file if the vendor is actively working on reducing the rest
of the subdirectory contents and consolidating over into device tree
based platforms. But we have also agreed that new (v7+) SoCs/boards
should be targeting DT board files from introduction nowadays.

Both these SoCs and boards seem to be A9-based, so they would match
that requirement.

The good news is that meeting the basic requirements for device tree
probing is easy; using a DT_MACHINE_START() stanza and adding a small
dts file is really all it takes for the real simple case. Building a
zImage with the device tree appended (and ARM_ATAG_DTB_COMPAT=y) means
you can use the same firmware as before and not modify it to handle
device trees, if that is a limitation you have for your environments.

Also, I would prefer to only see one or a couple of defconfigs that
can provide full build coverage for the various SoCs and boards, that
would contain the superset of the required drivers to boot the
supported boards, etc.

So, I'm going to hold off pulling in this branch right now until we
can sort out some of the above items.


Regards,

-Olof
