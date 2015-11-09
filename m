From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Nov 2015 16:04:03 -0800
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <20151102191923.GO19782@codeaurora.org>
References: <20151023180711.GA11749@lukather> <4745252.gLSrJNQ42D@wuerfel>
 <9946613.K7Ehp1DEiL@wuerfel> <20151025201308.GS10947@lukather>
 <20151026010752.GG14238@localhost>
 <CAGb2v671MmpRHkWKpOd8kmEbvfTKTU9k7AU_bP+AgRuguodWkQ@mail.gmail.com>
 <20151026054828.GD4216@localhost> <20151026103409.GX10947@lukather>
 <CAOesGMjNQeaA0etj0fk0E_QPNLYA3WTaRCfWE7YFz50RoDXu-w@mail.gmail.com>
 <20151102191923.GO19782@codeaurora.org>
Message-ID: <20151109000403.GU6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 11:19:23AM -0800, Stephen Boyd wrote:
> > >> I've merged this in now. Note that this has resulted in a tree that won't
> > >> misect cleanly, since having the clk contents merged instead of used as a base
> > >> for the dt branch means that you could end up in a bisect state that has the DT
> > >> branch but not the clk branch.
> > >
> > > Even if it has been merged before the DT patches have been applied?
> > > That's not really what I'd expect from bisect :/
> > 
> > Yeah, due to the way bisect works, the only way to guarantee
> > bisectability is if you base the DT branch on top of the clk branch
> > when you build it. Otherwise the bisect can come down the path of only
> > having the DT contents not the clk contents.
> 
> Why can't the dts changes be applied directly on top of the
> branch that's in the clk tree and then sent off to arm-soc? The
> git merge && git commit technique also works, but it introduces
> an unnecessary merge commit into the history.

Wouldn't that mean that you have to rebase your whole DT branch
whenever a single patch introduces a dependency on some clock patch?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/9ad61516/attachment-0001.sig>
