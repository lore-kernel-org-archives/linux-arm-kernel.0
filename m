From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:14:02 +0200
Subject: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
In-Reply-To: <20180327215332.GC28163@mithrandir>
References: <20180223101254.GA5746@lenoch> <20180223101553.GE5746@lenoch>
 <20180327215332.GC28163@mithrandir>
Message-ID: <20180327221401.GD28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 11:53:33PM +0200, Thierry Reding wrote:
> On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> > Prescaler setting is currently not taken into account.
> > Fix that by introducing freq member variable and initialize
> > it at device probe time. This also avoids frequency
> > recomputing at each pwm configure time.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++-----------------
> >  1 file changed, 55 insertions(+), 38 deletions(-)
> 
> Applied, thanks.

Actually, that was a little premature. It seems like this conflicts with
a patch series by Keerthy that Tony merged into his tree and that you've
based this on.

I think it'd be easiest if Tony merged this through the TI tree, or we
wait until v4.17-rc1 to resolve the dependency. Given how late we are in
the release cycle, I think it'd have to be the latter.

Tony, if you think you can find a way to still take this in for
v4.17-rc1, feel free to do so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/c2b783c6/attachment.sig>
