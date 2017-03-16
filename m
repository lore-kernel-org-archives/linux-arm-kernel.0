From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Thu, 16 Mar 2017 06:48:40 +0100
Subject: [PATCH] ARM: dts: mvebu: linksys: enable buffer manager support
In-Reply-To: <8760jafiy8.fsf@free-electrons.com>
References: <20170308053312.29243-1-ralph.sennhauser@gmail.com>
 <8760jafiy8.fsf@free-electrons.com>
Message-ID: <20170316064840.3398bd26@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Mar 2017 20:17:35 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Ralph,
>  
>  On mer., mars 08 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com>
> wrote:
> 
> </snip>
>
> > @@ -88,6 +89,9 @@
> >  			ethernet at 70000 {
> >  				status = "okay";
> >  				phy-mode = "rgmii-id";
> > +				buffer-manager = <&bm>;
> > +				bm,pool-long = <1>;
> > +				bm,pool-short = <3>;
> >  				fixed-link {
> >  					speed = <1000>;
> >  					full-duplex;
> > @@ -97,6 +101,9 @@
> >  			ethernet at 34000 {
> >  				status = "okay";
> >  				phy-mode = "sgmii";
> > +				buffer-manager = <&bm>;
> > +				bm,pool-long = <0>;
> > +				bm,pool-short = <3>;  
> Any reason to reuse the same pool than the other port?
> 
> As only two ports are used here, then each of them can have use 2 of
> the 4 availables pools. 
> 
> </snip>

Hi Gregory,

It has been quite a while since I have written that patch. Something
written somewhere in the Documentation / commit message which I can't
find anymore gave me the impression that using the same for short
doesn't make a difference. So I went with the pool IDs used for other
similar boards for "consistency".

Will send a v2 shortly using all independent pools using the IDs witch
come most natural in context.

Thanks
Ralph
