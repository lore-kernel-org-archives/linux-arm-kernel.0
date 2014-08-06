From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Aug 2014 16:30:26 +0200
Subject: [RFC 0/8] DPCM with simple-card support for Kirkwood
In-Reply-To: <20140806103356.4e7c088a@armhf>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
 <20140806103356.4e7c088a@armhf>
Message-ID: <20140806143026.GA19574@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 10:33:56AM +0200, Jean-Francois Moine wrote:
> On Wed,  6 Aug 2014 03:18:24 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > 30 June you posted your code to implement DPCM for kirkwood-i2s,
> > making it possible to use both I2S and SPDIF at the same time.
> > 
> > It has taken me a while, but i now have this patch on 3.16-rc6, and
> > i've extended simple-card to support DPCM. I've tested it on a
> > kirkwood based HP T5325, which only makes use of the I2S backend.
> > 
> > Please could you take a look and see if this helps to unblock getting
> > your Cubox support into mainline.
> 
> Andrew,
> 
> I had quite the same code as yours end 2013, and, if I did not miss
> something:

Hi Jean

At the moment, i'm not so interested in details, but more about, is
this the right direction to allow Russell to progress. Once i know
that, we can work on details.
 
> - you cannot put Linux specific stuff in the DT:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070595.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070622.html

The binding is not nice, and i know that. I want to simplify it. I
need to look at other DPCM users and see what is possible. It might be
i can just have two booleans: dpcm_frontend and dpcm_backend, and
derive everything else from these. As of 3.16, there only appears to
be one other dpcm user, intel haswell. There is a lot in common with
kirkwood, needing to use the snd-soc-dummy, dummy platform, setting
no_pcm, etc. So for simple-card, i can probably just assume these can
be implied from flags like dpcm_frontend and dpcm_backend? It looks
like you had the same idea at the end of 2013.
 
> - the DPCM code does not handle the formats and rates of the back-ends:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070585.html
> 
> Some more information may be found at:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070798.html

I've not run into these problems, but i have not tested too much. Once
we have the general direction decided, we should try to work on this
together to fix it.

	 Andrew
