From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 2 Feb 2014 19:06:06 +0100
Subject: [PATCH v5 00/23]
In-Reply-To: <20140202124358.GD26684@n2100.arm.linux.org.uk>
References: <cover.1390986082.git.moinejf@free.fr>
 <20140202124358.GD26684@n2100.arm.linux.org.uk>
Message-ID: <20140202190606.6fa193ce@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2 Feb 2014 12:43:58 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jan 29, 2014 at 10:01:22AM +0100, Jean-Francois Moine wrote:
> > This patch set contains various extensions to the tda998x driver:
> > 
> > - simplify the i2c read/write
> > - code cleanup and fix some small errors
> > - use global constants
> > - don't read write-only registers
> > - add DT support
> > - use IRQ for connection status and EDID read
> 
> I discussed these patches with Rob Clark recently, and the conclusion
> we came to is that I'll merge them into a git tree, test them, and
> once I'm happy I'll send a pull request as appropriate.
> 
> I'll go through them later today.  Those patches which have been re-
> posted without any change for the last few times (the first few) I'll
> take into my git tree today so you don't have to keep re-posting them
> (more importantly, I won't have to keep on looking at them either.)

Thanks.

BTW, I found some problems with the patch 12 'add DT support' you
already acked:

- the .of_match_table is not needed because the i2c client is created by
  the i2c subsystem from the 'reg' in the DT,

- on encoder_destroy(), the function drm_i2c_encoder_destroy()
  unregisters the i2c client, so, with a DT, a second encoder_init()
  would crash.

Do you better like a new patch or a fix?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
