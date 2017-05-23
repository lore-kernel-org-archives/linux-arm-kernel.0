From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 18:10:01 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: introduce rk3399-op1 operating
 points
In-Reply-To: <CAD=FV=XbUjuvt+ctm8Xw6JPqe7m4PdyZ1hm3Uast2+1+nJ=nPw@mail.gmail.com>
References: <20170523095109.7337-1-heiko@sntech.de>
 <20170523095109.7337-2-heiko@sntech.de>
 <CAD=FV=XbUjuvt+ctm8Xw6JPqe7m4PdyZ1hm3Uast2+1+nJ=nPw@mail.gmail.com>
Message-ID: <1597629.2TFUO1J4Mt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Mai 2017, 08:57:01 CEST schrieb Doug Anderson:
> Hi,
> 
> On Tue, May 23, 2017 at 2:51 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> > The OP1 is a rk3399 variant used in ChromeOS devices with a slightly
> > higher frequency rating. Therefore introduce separate operting points,
> > from the ChromeOS tree, for it and use it in Gru devices.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi     |   2 +-
> >  arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 145 +++++++++++++++++++++++
> >  2 files changed, 146 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> 
> The numbers here match what's in the Chrome OS tree and those were all
> approved by Rockchip.
> 
> One slight nit is that the descriptions these two patches together
> make it look like this will be a no-op change for OP1 devices.  This
> is not true.  After things were posted upstream there have been
> several adjustments to the opp points in the Chrome OS tree.  Since
> what you have currently matches the ToT Chrome OS tree, that should
> mean that there's a net difference.  It would be nice to mention that
> in the commit message.

In the mainline kernel it is a no-op change, as we're still running with
the cpu-regulators disabled on gru ;-)

But to address your very valid point, I guess you mean something like

----
The OP1 is a rk3399 variant used in ChromeOS devices with a slightly
higher frequency rating compared to the regular rk3399, but right now
the only available operating points are somewhere in between both
variants with both needing adjustments to actually fit their specs.

Therefore introduce separate operting points, from the ChromeOS kernel,
for the OP1 and use it on Gru devices.
----

And I guess we should also swap patch ordering, first move Gru away from
the general opps and then adust them for the regular rk3399.


> Other than that small nit:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>


Heiko
