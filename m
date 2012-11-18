From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 18 Nov 2012 19:27:55 +0100
Subject: [PATCH v2 2/2] ARM: Kirkwood: Convert XOR instantiation to DT.
In-Reply-To: <20121118184032.6bb52037@skate>
References: <1353235498-22638-1-git-send-email-andrew@lunn.ch>
 <1353235498-22638-2-git-send-email-andrew@lunn.ch>
 <20121118184032.6bb52037@skate>
Message-ID: <20121118182755.GF14643@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 06:40:32PM +0100, Thomas Petazzoni wrote:
> Andrew,
> 
> On Sun, 18 Nov 2012 11:44:57 +0100, Andrew Lunn wrote:
> > Use DT to describe the two XOR DMA engines on Kirkwood. Remove the
> > C code initialization.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > These patches depend on the refactoring/DT patches from Thomas and NOT
> > the clock patches from me. With the clock patches, a slight different
> > patch is needed, specifying a clocks property in DT and no auxdata.
> 
> My XOR patch set already depended on the previous clock series from
> Gregory, so I'm going to rebase it on top of your clock series. Would
> you mind sharing with me the version of this patch that works on top of
> your clock patch set?

Hi Thomas

I never create the patch for on top of my clock series.

> I guess it's just the removal of the auxdata, and addition of
> 
> 	clocks = <&gate_clk 8>;
> 
> for the first XOR engine, and:
> 
> 	clocks = <&gate_clk 16>;
> 
> for the second XOR engine.

Correct.

> 
> If this is correct, I'll integrate your patch in my XOR patches so that
> you'll get a complete pull request with all the related XOR changes.

O.K.

We probably need a new ACK from Mike Turquette for the updated clock
patches.

      Andrew
