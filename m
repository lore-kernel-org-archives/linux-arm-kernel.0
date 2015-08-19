From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 19 Aug 2015 11:48:44 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <20150819091358.GA26627@ulmo>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
 <20150819091358.GA26627@ulmo>
Message-ID: <1439977724.4135.90.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-19 at 11:14 +0200, Thierry Reding wrote:
> On Tue, Aug 18, 2015 at 03:30:41PM -0700, Tyler Baker wrote:
> > Hi Theirry,
> > 
> > 
> > This isn't where the story ends unfortunately. The collabora lab 
> > also
> > has a jetson-tk1, booted in the same manner, which boots next
> > -20150818
> > fine[4]. The only differences I can spot in the two boot logs is 
> > that
> > the collabora board is using an older version of u-boot, where as 
> > my
> > board is using a newer version. U-Boot 2015.01-00231-gab77f24-dirty
> > (Good) vs U-Boot 2015.07-00130-gb217c89 (Bad).

Our 2015.01-00231-gab77f24-dirty is 2015.01-00231-gab77f24 + changes
which got merged as 053b86e6d8e50359412e626c33bae3f7bafd74dd in
upstream u-boot.

Fwiw:
$ git show 2015.01-00231-gab77f24
commit ab77f24119e80257de4ab017b877f92f96980562
Merge: d928664 fa58b10
Author: Tom Rini <trini@ti.com>
Date:   Thu Jan 15 14:05:31 2015 -0500

    Merge branch 'master' of git://git.denx.de/u-boot-ti

Which is definately a commit you should hae in your upstream u-boot
tree.




> I don't have either of those commits in any of the U-Boot trees I 
> have.
> Perhaps whatever tree this comes from has local patches that cause 
> the
> breakage? The version that I use a recent upstream U-Boot with some
> local patches, none of which should impact Jetson TK1 in any way. 
> Just
> to make sure I tried running latest origin/master, which identifies
> thusly:
> 
> 	U-Boot 2015.10-rc2-00040-g0f9258228e2b
> 
> And that boots next-20150818 fine.

Probably worth for tyler to test that u-boot commit on his jetson to
see if that solves the issue he's having...

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
