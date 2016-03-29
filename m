From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Mar 2016 11:03:33 +0200
Subject: [PATCH v3 2/5] dmaengine: sun6i: Add 4 as a possible burst
 value for the H3
In-Reply-To: <20160329064650.GG30977@lukather>
References: <cover.1458311540.git.moinejf@free.fr>
 <8485d9976f327cf23e051f64c3a3c5cbff4214a7.1458311540.git.moinejf@free.fr>
 <20160321072918.GV30977@lukather>
 <20160321093533.c91912e9ac263d9c003355e2@free.fr>
 <20160329064650.GG30977@lukather>
Message-ID: <20160329110333.98b6bfad38dd44950c35d6f2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016 08:46:50 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Mon, Mar 21, 2016 at 09:35:33AM +0100, Jean-Francois Moine wrote:
> > On Mon, 21 Mar 2016 08:29:18 +0100
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > 
> > > > @@ -470,6 +473,10 @@ static int set_config(struct sun6i_dma_dev *sdev,
> > > >  {
> > > >  	s8 src_width, dst_width, src_burst, dst_burst;
> > > >  
> > > > +	if (!sdev->cfg->burst_4 &&
> > > > +	    (sconfig->src_maxburst == 4 || sconfig->dst_maxburst == 4))
> > > > +		return -EINVAL;
> > > > +
> > > 
> > > I still believe this should be dealt with at the framework level.
> > 
> > What do you mean? In the DMA clients?
> 
> No, in the dmaengine framework.
> 
> A driver should register the burst size they support, and
> dmaengine_slave_config would reject any invalid burst size based on
> that.

Maybe you are right, but this does not seem to be very easy: the max
burst size is on a u32 value, and, as a bit map (256Mb) is forbidden,
the DMA drivers should declare a list of (min, max) authorized values.

Well, I will not start such a development for just testing if 4 is a
good burst size when calling the sun6i DMA driver...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
