From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jan 2018 10:26:48 +0100
Subject: [PATCH v2 03/16] ARM: dts: r8a7790: sort subnodes of soc node
In-Reply-To: <CAMuHMdV65W0jAH9u3vGyrZrD3VjV_4XotFKdsNx6gVCU8nyJQw@mail.gmail.com>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-4-horms+renesas@verge.net.au>
 <CAMuHMdV65W0jAH9u3vGyrZrD3VjV_4XotFKdsNx6gVCU8nyJQw@mail.gmail.com>
Message-ID: <20180119092647.iumaljyi5mtwa4gr@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 09:39:24AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 17, 2018 at 5:17 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Sort the subnodes of the soc node to improve maintainability.
> > The sort key is the addresss on the bus with instances of the same
> > IP block grouped together.
> >
> > This patch should not introduce any functional change.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The sort order for the various SCIF variants is still a bit odd:
> 
>         scifa0: serial at e6c40000 {
>         scifa1: serial at e6c50000 {
>         scifa2: serial at e6c60000 {
>         scifb0: serial at e6c20000 {
>         scifb1: serial at e6c30000 {
>         scifb2: serial at e6ce0000 {
>         scif0: serial at e6e60000 {
>         scif1: serial at e6e68000 {
>         scif2: serial at e6e56000 {
>         hscif0: serial at e62c0000 {
>         hscif1: serial at e62c8000 {
> 
> (hscif0 has the lowest address)
> 
> But hey, SCIF is special ;-)

Right, I decided to keep the SCIF ordering as is.
My preference is to address this later if we come up with a better scheme.
