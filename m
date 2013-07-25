From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 25 Jul 2013 22:53:15 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130725203228.GX23879@titan.lakedaemon.net>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <CAL_Jsq+vWbTb8wNEDCR2c_M6sBnKW6e5HGk48QzmXSujQUdddA@mail.gmail.com>
 <20130725203228.GX23879@titan.lakedaemon.net>
Message-ID: <20130725215315.GV7729@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 04:32:28PM -0400, Jason Cooper wrote:
[...]
> One of the things I've been trying to square up in my head is how to
> retain the history of the binding when moving to the new tree.  My
> current idea was to clone the kernel tree, add one patch deleting
> everything but the bindings and dts files, and one more patch moving
> things where we want them (arch/{powerpc,arm}/boot/dts -> dts).
> 
> Then, as needed, we could merge a kernel version tag and delete
> everything we don't need (code) in the merge commit.
> 
> The downside of this is it would be messy, the upside is that we could
> closely track the kernel tree (until the bindings and dts are moved
> out), and retain the history of the bindings and dts files.
[...]

It's *extremely* messy, but 'git filter-branch' might help to make a
clean tracking branch preserving history of just DT files.  David
Woodhouse did something like that for the linux-firmware repo
initially.

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
