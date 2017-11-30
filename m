From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Nov 2017 10:43:55 +0100
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Enable NFS root
In-Reply-To: <CAMuHMdXbvC90k1QYZsjWx=f7QVQyWOzi_v3u8ShDoDsSAmZsjw@mail.gmail.com>
References: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXbvC90k1QYZsjWx=f7QVQyWOzi_v3u8ShDoDsSAmZsjw@mail.gmail.com>
Message-ID: <20171130094354.6pktdlcuc3gettji@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 11:27:58AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, May 2, 2017 at 11:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Enable NFS root on the r8a7795/h3ulcb and r8a7796/m3ulcb
> > as per:
> > * commit b2407c566ba29215 ("arm64: dts: r8a7795: enable nfs root on Salvator-X board").
> > * commit 742a9dfb90f0 ("arm64: dts: r8a7796: salvator-x: Enable NFS root")
> >
> > Also set ignore_loglevel rw as boot args as is the case for the boards
> > for the boards for other Renesas ARM/ARM64 based SoCs.
> 
> s/for the boards//
> 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,

Sergei has pointed out that bootargs has seems to have effect on ARM64
kernels. So I think this patch should be withdrawn and we should consider
removing bootargs from those ARM64 boards where it is present.
