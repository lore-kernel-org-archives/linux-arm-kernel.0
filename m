From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 24 Sep 2013 18:32:41 +0200
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20130924105127.GB12758@n2100.arm.linux.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20130924105127.GB12758@n2100.arm.linux.org.uk>
Message-ID: <20130924183241.12a97af4@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Sep 2013 11:51:27 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> > This patch adds S/PDIF input/output for mvebu DT boards.
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> 
> Right, so if this goes in, then we're completely fucked for doing this
> the way that Mark apparantly wants it to be done, because once these
> DT properties go in, they're there to stay.

Indeed!

The DT properties I propose just reflect the hardware connections of
the board. There are only i2s-out and spdif-out in the Cubox, while
there may be kirkwood boards with, say, only spdif-in and spdif-out.

These definitions do not interfere with your DPCM problem: you assume
i2s-out and spdif-out for the i2s1 dove device, and that is what I
assume too, but from the DT. Then, the driver does not need to know the
type of the audio device (Kirkwood or Dove), nor to know if it is the
first or the second i2s device of the Dove chip.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
