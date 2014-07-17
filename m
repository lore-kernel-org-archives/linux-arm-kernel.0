From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Jul 2014 16:20:39 +0200
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <20140710101527.GC21583@ulmo>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <20140707003854.GD8469@quad.lixom.net>
 <20140707055211.GA15216@ulmo>
 <CAOesGMjwE=xThuUwmBF02YaQ32_uFogryW5anNoGc8yfkuN_Pg@mail.gmail.com>
 <20140710101527.GC21583@ulmo>
Message-ID: <20140717142037.GA17494@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 12:15:28PM +0200, Thierry Reding wrote:
> On Mon, Jul 07, 2014 at 09:45:46PM -0700, Olof Johansson wrote:
[...]
> > If you have to stay compatible, then I suggest you try to fill in
> > local driver variables with derivatives of the old properties (and
> > directly from the newer properties where you can). I haven't looked at
> > the specifics here so I don't know how hard it might be.
> > 
> > If you are 100% sure that you don't have to stay compatible, then you
> > can remove the code handling the old bindings. Still, even then I am a
> > little worried about dependencies (and more importantly conflicts)
> > between these dtsi changes and others done by tegra platform code for
> > this release. I suppose that can be resolved by having this as a base
> > of any DT changes for tegra if needed.
> 
> To be honest, I'm very much tempted to just drop this series. Even if
> that means keeping a totally broken DT binding. But frankly I don't have
> any energy left to debate DT stability.

So this kept bugging me and I couldn't leave it alone after all. How
about if I squash in the attached patch. I've verified that that keeps
compatibility with old device trees on TrimSlice and Beaver. I think the
remainder of the series could still remain as-is (the top few commits
that you said shouldn't be there) if I squash this into

	PCI: tegra: Implement accurate power supply scheme

That way the binding will be the new one so that people don't get any
wrong ideas about taking shortcuts while still preserving compatibility
with existing DTBs.

Interestingly, despite my initial disgust for having to keep around old
code (it's in fact new code in this case) for compatibility reasons, it
ended up making the code look more mature.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-PCI-tegra-Preserve-DT-backwards-compatibility.patch
Type: text/x-diff
Size: 3572 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/2f969e7c/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/2f969e7c/attachment-0001.sig>
