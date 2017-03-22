From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:20:27 -0700
Subject: [PATCH 2/2] arm64: dts: add arm/arm64 include symlinks
In-Reply-To: <20170320230337.GB78325@google.com>
References: <20170226060058.5841-1-heiko@sntech.de>
 <20170226060058.5841-2-heiko@sntech.de>
 <20170320230337.GB78325@google.com>
Message-ID: <20170322002027.GA2984@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 04:03:37PM -0700, Brian Norris wrote:
> Hi,
> 
> On Sun, Feb 26, 2017 at 07:00:58AM +0100, Heiko Stuebner wrote:
> > Allow including of dtsi files in an architecture-independent manner.
> > Some dtsi files may be shared between architectures and one suggestion
> > was to have symlinks and let these includes get accessed via a
> >     #include <arm64/foo.dtsi>
> > So add the necessary symlinks for arm32.
> > 
> > Suggested-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Suggested by Olof in response to the patch adding direct symlinks
> > for cros-ec includes.
> > 
> > Tested with adapted rk3399-Gru dtsi files and while we only need this arm64
> > version right now, it might make sense to already have both the arm32 and
> > arm64 versions ready.
> 
> FWIW, tested fine here too (for the same platform).
> 
> I guess this works fine, if it makes people happy. It also allows some
> weird #include paths. e.g.:
> 
> #include <arm64/include/arm/include/arm64/rockchip/rk3399.dtsi>
> 
> I guess we can call that an entertaining feature, and not a bug?
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> 
> Where should this go? I'd like not to wait another few months before
> sending my Gru/Kevin DTS again.

Checked into shared/dt-symlinks on the arm-soc repo now (and merged into
next/dt and next/dt64). Please use that branch as a base for DT material that
will use this.


-Olof
