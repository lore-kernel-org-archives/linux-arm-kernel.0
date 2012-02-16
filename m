From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 19:34:14 +0000
Subject: ftp.arm.linux.org.uk now using dumb http git protocol
In-Reply-To: <alpine.LFD.2.02.1202161309450.24536@xanadu.home>
References: <20120216131144.GM13673@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1202161309450.24536@xanadu.home>
Message-ID: <20120216193414.GJ27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 01:29:21PM -0500, Nicolas Pitre wrote:
> On Thu, 16 Feb 2012, Russell King - ARM Linux wrote:
> > This action puts more load on the server, load it can do without.
> > 
> > So, as of a couple of days ago, it's now using the dumb http stuff,
> > which means if you abort it, you _will_ get corrupted pack files in
> > your .git/objects/pack directory.
> > 
> > You can avoid much of that pain by following what you should've been
> > doing in the first place: first update your trees by pulling from
> > Linus' tree.  Then, and only then, update your tree from my tree.
> > Doing that will minimise the time you have to wait, and minimise the
> > chance of a corrupted pack file.
> 
> That will work only if Linus' tree is contained in a pack of its own on 
> the server, and your stuff not mixed up with it.

That is guaranteed by the way I fetch Linus' tree and push my tree to
there - for the git objects and packs, it's all rsync based.
