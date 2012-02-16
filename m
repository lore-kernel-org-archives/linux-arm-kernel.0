From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 13:11:44 +0000
Subject: ftp.arm.linux.org.uk now using dumb http git protocol
Message-ID: <20120216131144.GM13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of days I disabled the smart git protocol over http on
ftp.arm.linux.org.uk because the smart git protocol over http is
far too heavyweight for the poor x86 machine.  It's now using the
lighter-weight dumb http file serving stuff instead.  This has made
the machine load go back to virtually zero instead of skyrocketing.

It's revealed something rather interesting though: people _have_ been
updating their trees from my tree without first ensuring that their tree
is up to date with Linus' tree.  I suspect people have been cloning
the tree as well.

This action puts more load on the server, load it can do without.

So, as of a couple of days ago, it's now using the dumb http stuff,
which means if you abort it, you _will_ get corrupted pack files in
your .git/objects/pack directory.

You can avoid much of that pain by following what you should've been
doing in the first place: first update your trees by pulling from
Linus' tree.  Then, and only then, update your tree from my tree.
Doing that will minimise the time you have to wait, and minimise the
chance of a corrupted pack file.

Thank you.
