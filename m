From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Apr 2015 09:26:52 +0200
Subject: [PATCH 1/2] sunxi: a20-LIME2 update regulator description
In-Reply-To: <551FAC01.8000404@gmail.com>
References: <55143CA1.7000606@gmail.com> <20150330231350.GA23664@lukather>
 <551FAC01.8000404@gmail.com>
Message-ID: <20150409072652.GJ26727@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 10:16:49AM +0100, Iain Paton wrote:
> On 31/03/15 00:13, Maxime Ripard wrote:
> > Hi,
> > 
> > On Thu, Mar 26, 2015 at 05:06:41PM +0000, Iain Paton wrote:
> >> configure regulators as per the manufacturers recomendations from their
> >> 3.4.x fex file.
> >>
> >> this is necessary to prevent operating points in the dtsi selecting
> >> inappropriate values and causing the board to lockup
> 
> > Could you use the axp DTSI please?
> > 
> > That will remove most of the chunk defined in there.
> 
> No. See my other reply. The regulators are even more board specific
> than the opp data and the interaction between the two is hard to
> handle at the best of times.
> 
> Using the axp dtsi means that the board dts really has to override
> every single possible item that could ever be added to the dtsi just
> to ensure stability.

Every single possible item it actually uses. Which should be defined
anyway in the board DTS anyway.

The *only* difference being that you won't have to define all the
regulators in your board DTS to have the *unused* ones disabled.

> This won't remove anything, it'll just add extra unnecessary stuff
> to the mix as well as the additional burden on people taking care of
> a board watching the axp dtsi to catch any additions there casuing
> further problems.

Again, it actually removes the fact that you have to declare all the
regulators in all the boards DTS, even if there not used at all on the
board. So the fact is it removes that churn

> Wishing these things were suitable for a common dtsi unfortunately
> doesn't change the reality whatsoever.

The reality being in this case that you defined an incomplete set of
regulators? Fair enough.

> I'm with you that exploiting commonality is generally a good thing. It's 
> just not appropriate here.
> 
> It also seems that most other boards have realised that the pmic
> setup is board specific and keep it in the appropriate place in the
> dts.
>
> The only other obvious example I can find apart from sunxi is TI,
> everyone else is doing the opposite.

Which means what exactly? Apart from being the only two users, I mean?

> So why the resistance?

You won't have to maintain these changes, I will. More uselessly
duplicated code means more useless effort, and I'm not really fond of
wasting my time.

> A repeat of the label based syntax / alphabetical ordering thing?

How is that even related?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/b368f930/attachment.sig>
