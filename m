From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Apr 2016 08:51:26 +1000
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <CAMuHMdWcsi0XE6htZW=V5DDKy8LX_1rdBoo_dEeDBvLcDeMFvw@mail.gmail.com>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAMuHMdWcsi0XE6htZW=V5DDKy8LX_1rdBoo_dEeDBvLcDeMFvw@mail.gmail.com>
Message-ID: <20160419225125.GB9826@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 09:18:55AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 6, 2016 at 2:52 PM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> > clk_get on a disabled clock node will return EPROBE_DEFER, which can
> > cause drivers to be deferred forever if such clocks are referenced in
> > their clocks property.
> >
> > Update the various disabled external clock nodes to default to a
> > frequency of 0, but don't disable them to prevent this.
> >
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I will add your tag.
