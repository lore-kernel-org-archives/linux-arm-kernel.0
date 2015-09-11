From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Sep 2015 17:59:48 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <55F2F895.5040704@nvidia.com>
References: <20150819091358.GA26627@ulmo>
 <1439977724.4135.90.camel@collabora.co.uk>
 <20150819103305.GF26627@ulmo>
 <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
 <CAMAWPa_rus4z+Sg3Uff7ndqrpB8dF1c1rQBVQ9r7vXh6PFcVkQ@mail.gmail.com>
 <55F2AF45.5040706@nvidia.com> <20150911123759.GA8473@ulmo>
 <55F2D2E3.4010906@nvidia.com> <20150911132526.GB21673@ulmo>
 <55F2F895.5040704@nvidia.com>
Message-ID: <20150911155946.GA13945@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 04:51:49PM +0100, Jon Hunter wrote:
> 
> On 11/09/15 14:25, Thierry Reding wrote:
> 
> [snip]
> 
> > Works for me 100% of the time. Unloading and reloading isn't a problem
> > either. What revision of the Jetson TK1 do you have? Mine is a C.2
> 
> Unfortunately, I am not sure it is whatever is in Paul's automation rig
> [0]. However, I have also reproduced this on a tegra124 nyan-big in the
> office.

I was able to reproduce this using a busybox initial ramdisk. Just to
make sure I built a separate one from git and it exposes the same
behaviour. I suspect that this is some sort of weird interaction between
mdev and async probing and nobody's noticed so far because async probing
isn't very common (at least in the ARM world).

I'll be off for the weekend soonish, but I'll try to find some more time
next week to track this down.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/c162e34f/attachment.sig>
