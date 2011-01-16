From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Jan 2011 09:23:15 +0000
Subject: cannot fetch arm git tree
In-Reply-To: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
Message-ID: <20110116092315.GA27542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 10:28:55AM +0800, Jello huang wrote:
> Dear Russell,
> 
> when i use git fetch,there arm some wrong with it.
> 
> jello at jello-laptop:~/git/russell/linux-2.6-arm$git pull
> error: Unable to find 89e4d4b145bb7e73b4c45671a84b401a5d8694c1 under
> http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> Cannot obtain needed blob 89e4d4b145bb7e73b4c45671a84b401a5d8694c1
> while processing commit eda2e5dcc914b4d70f665443efc9780e89a5e5c1.
> error: Fetch failed.
> 
> What is the wrong?

No idea.  The tree has the object file in one of its pack files:

| rmk at ZenIV:[linux-2.6-arm.git]:<1020> GIT_DIR=. git cat-file -p 89e4d4b145bb7e73b4c45671a84b401a5d8694c1|head
| 
|         List of maintainers and how to submit kernel changes
| 
| Please try to follow the guidelines below.  This will make things
| easier on the maintainers.  Not all of these guidelines matter for every
| trivial patch so apply some common sense.

and the pack info file lists all the pack files.  Maybe you have a hash
collision on a pack file with your repository?

I suggest you do as I've always recommended: make sure your tree is up to
date with Linus' tree before fetching my tree.  That way you avoid the
unnecessary download of large pack files.

> I have found the discussion linux-next: manual merge of
> the arm tree with the arm-current
> tree<http://forum.soft32.com/linux/linux-manual-merge-arm-tree-arm-current-tree-ftopict523173.html>
> with
> Uwe.But there is also Puzzled with me now.

How so?
