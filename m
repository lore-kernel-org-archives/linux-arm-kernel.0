From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 08:58:54 +0900
Subject: Renesas clock clk-mstp updates for clock-indices
In-Reply-To: <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
Message-ID: <20140415235851.GA9817@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 11:26:20AM +0200, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Fri, Mar 7, 2014 at 1:46 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > Mike, following the commit to add the clock-indices field, the following
> > pair of commits updates the shmboile clk-mstp driver to uses these over
> > the local variant.
> >
> > Since this is involves two separte trees which are in development, the
> > decision is that we will fixup the renesas trees once they are merged
> > and the development cycle is complete. Once this is done, patch 2/2
> > can be reverted (if people care about three lines of differrence)
> 
> As we now have "renesas,clock-indices" in v3.14, the question about backwards
> compatibility became moot.
> 
> Can you please combine your two patches
> 
> [PATCH 1/2] clk: shmobile: clk-mstp: change to using clock-indices
> [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field
> 
> into a single patch, and submit to Mike?
> 
> Once it's in Mike's clk-next, we can do the following to get everything in
> v3.15:
>   1. Simon cherry-picks Mike's commit into his fixes-for-v3.15 branch,
>   2. we fix arch/arm/boot/dts/r8a7790.dtsi and .../r8a7791.dtsi there,
>   3. fixes-for-v3.15 gets into mainline through arm-soc.
> 
> Does that sound like plan?

I think a better approach would be for me to use a branch of Mike's
or an rc release as a basis for steps 2. and 3. Once such a branch
or rc release is available.
