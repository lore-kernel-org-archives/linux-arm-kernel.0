From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Feb 2015 08:51:47 -0500
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix audio clk master to SSI
 and change audio data interface format type
In-Reply-To: <87fva6n2pb.wl%kuninori.morimoto.gx@renesas.com>
References: <1424011746-3787-1-git-send-email-ykaneko0929@gmail.com>
 <20150215152957.GA25065@verge.net.au>
 <87fva6n2pb.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20150216135141.GA3622@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Mon, Feb 16, 2015 at 12:01:15AM +0000, Kuninori Morimoto wrote:
> 
> Hi Kaneko-san, Simon
> 
> > >  arch/arm/boot/dts/r8a7790-lager.dts | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > > index 0c3b678..e7dda8a 100644
> > > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > > @@ -177,9 +177,7 @@
> > >  	sound {
> > >  		compatible = "simple-audio-card";
> > >  
> > > -		simple-audio-card,format = "left_j";
> > > -		simple-audio-card,bitclock-master = <&sndcodec>;
> > > -		simple-audio-card,frame-master = <&sndcodec>;
> > > +		simple-audio-card,format = "i2s";
> > >  
> > >  		sndcpu: simple-audio-card,cpu {
> > >  			sound-dai = <&rcar_sound>;
> 
> Unfortunately, I can't accept this patch.
> It will be strange sound if you change clk master to SSI (*1).
> Additionally, it needs audio_clk settings for SSI master,
> but, it needs special limitation (*1).
> (*1 HW connection reason)
> And format change left_j -> i2s is no meaning on Lager board case

Thanks for your analysis.
I am marking this patch as "rejected".
