From: ruifeihuang@gmail.com (Jello huang)
Date: Mon, 17 Jan 2011 09:49:28 +0800
Subject: cannot fetch arm git tree
In-Reply-To: <20110116134248.GD27542@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=VPj2JVnkjv-ja48OUwJZR3zhDYcvSeps1X8x1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,thanks for your reply so elaborate and i have gotten the idea now.

On 16 January 2011 21:42, Russell King - ARM Linux
<linux@arm.linux.org.uk>wrote:

> On Sun, Jan 16, 2011 at 09:10:17PM +0800, Jello huang wrote:
> > yes,git doesn't  handle that case and i rename the pack name,but there is
> > also the similar error.Now i just delet the git tree and  clone it again
> > tonight .
>
> _Always_ without fail fetch Linus' tree before pulling my tree.
>
> My tree is a rsync clone of the objects and pack files in Linus' tree,
> plus whatever git decided to build on top of that - for local commits
> that's individual object files.  For remote pulls, that's probably a few
> small pack files.
>
> There is *no* repacking of my tree.  So the only times it gets 'repacked'
> is when Linus repacks his tree.
>
> Let's say you already have a copy of my tree from a month ago, and Linus
> has pulled some work from me into his tree, and repacked his tree into one
> single pack file.  At the moment, the largest pack file from Linus is
> 400MB plus a 50MB index.
>
> You already have most of the contents of that 400MB pack file, but if
> you're missing even _one_ object which is contained within it, git will
> have to download the _entire_ 400MB pack file and index file to retrieve
> it.
>
> However, if you first fetch Linus' tree via the git protocol, it can just
> request the objects it doesn't have from the git server.  That will mean
> you'll have all the objects in the large pack files before you start trying
> to pull my tree, and git won't have to download 400MB for the sake of
> retrieving just maybe 10k that you didn't have.
>
> This isn't something special with my tree - it's a side effect of the
> http protocol git uses.  So, before you fetch _any_ http-based git tree,
> first make sure you're up to date with Linus'.
>
> (I update my tree from Linus' in rsync mode to make http-based stuff a
> lot more friendly to people using it - some of whom are stuck behind
> firewalls which can only do http.  Fetching a constantly repacked git
> tree via http results in hundreds of megabytes needing to be fetched
> every time.)
>
> So please, whenever possible, always fetch Linus' latest tree _first_
> and then mine.  Same goes for any other http based tree which doesn't
> auto-repack.
>



-- 
JUST DO IT,NOTHING IS IMPOSSIBLE
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110117/7875fdbd/attachment-0001.html>
