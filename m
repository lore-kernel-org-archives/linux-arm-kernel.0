From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 23:30:42 +0000
Subject: [PATCH v3 20/24] media: imx: Add Camera Interface subdev driver
In-Reply-To: <d5ede043-3b02-37f6-bd4a-db805e6b36d7@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-21-git-send-email-steve_longerbeam@mentor.com>
 <b7456d40-040d-41b7-45bc-ef6709ab7933@xs4all.nl>
 <20170131134252.GX27312@n2100.armlinux.org.uk>
 <b0517394-7717-3e1d-b850-e2b69a9c19e9@gmail.com>
 <20170131203340.GC27312@n2100.armlinux.org.uk>
 <2297c62c-ae9b-3942-4700-ce268a61a6d5@gmail.com>
 <20170131220452.GE27312@n2100.armlinux.org.uk>
 <d5ede043-3b02-37f6-bd4a-db805e6b36d7@mentor.com>
Message-ID: <20170131233042.GF27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 02:36:53PM -0800, Steve Longerbeam wrote:
> On 01/31/2017 02:04 PM, Russell King - ARM Linux wrote:
> >I don't want master though, I want v4.10-rc1, and if I ask for that
> >it tells me it knows nothing about v4.10-rc1, despite the fact that's
> >a tag in the mainline kernel repository which was merged into the
> >linux-media tree that this tree is based upon.
> 
> Hi Russell, yes git at github.com:slongerbeam/mediatree.git is a fork
> of the linux-media tree, and the imx-media-staging-md-wip branch
> is up-to-date with master, currently at 4.10-rc1.

"up to date" is different from "contains other stuff other than is in
4.10-rc1".

What I see in your tree is that your code is based off a merge commit
between something called "patchwork" (which I assume is a branch in
the media tree containing stuff commited from patch work) and v4.10-rc1.

Now, you don't get a commit when merging unless there's changes that
aren't in the commit you're merging - if "patchwork" was up to date
with v4.10-rc1, then git would have done a "fast forward" to v4.10-rc1.

Therefore, while it may be "up to date" with v4.10-rc1 in so far that
it's had v4.10-rc1 merged into it, that's not what I've been saying.
There are other changes below that merge commit which aren't in
v4.10-rc1.  It's those other changes that I'm talking about, and it's
those other changes I do not want without knowing what they are.

It may be that those other changes have since been merged into
v4.10-rc6 - but github's web interface can't show me that.  In fact,
github's web interface is pretty damned useless as far as this stuff
goes.

So, what I'll get if I clone or pull your imx-media-staging-md-wip
branch is, yes, a copy of all your changes, but _also_ all the
changes that are in the media tree that _aren't_ in mainline at the
point that v4.10-rc1 was merged.

> You don't need to use the web interface, just git clone the repo.

You're assuming I want to work off the top of your commits.  I don't.
I've got other dependencies.

Then there's yet another problem - lets say that I get a copy of your
patches that haven't been on the mailing list, and I then want to make
a comment about it.  I can't reply to a patch that hasn't been on the
mailing list.  So, the long established mechanism by which the Linux
community does patch review breaks down.

So no, sorry, I'm not fetching your tree, and I will persist with your
v3 patch set for the time being.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
