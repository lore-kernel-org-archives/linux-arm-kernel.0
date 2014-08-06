From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 6 Aug 2014 10:33:56 +0200
Subject: [RFC 0/8] DPCM with simple-card support for Kirkwood
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140806103356.4e7c088a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  6 Aug 2014 03:18:24 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> 30 June you posted your code to implement DPCM for kirkwood-i2s,
> making it possible to use both I2S and SPDIF at the same time.
> 
> It has taken me a while, but i now have this patch on 3.16-rc6, and
> i've extended simple-card to support DPCM. I've tested it on a
> kirkwood based HP T5325, which only makes use of the I2S backend.
> 
> Please could you take a look and see if this helps to unblock getting
> your Cubox support into mainline.

Andrew,

I had quite the same code as yours end 2013, and, if I did not miss
something:

- you cannot put Linux specific stuff in the DT:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070595.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070622.html

- the DPCM code does not handle the formats and rates of the back-ends:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070585.html

Some more information may be found at:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070798.html

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
