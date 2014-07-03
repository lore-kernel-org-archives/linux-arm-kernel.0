From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 3 Jul 2014 18:26:00 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140703154325.GY32514@n2100.arm.linux.org.uk>
References: <20140702165628.GO20799@lunn.ch> <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
 <20140703133406.2d3e3a1d@armhf>
 <20140703115924.GY410@sirena.org.uk>
 <20140703152826.103c9d6c@armhf>
 <20140703134346.GW32514@n2100.arm.linux.org.uk>
 <20140703172909.60caf2c7@armhf>
 <20140703154325.GY32514@n2100.arm.linux.org.uk>
Message-ID: <20140703182600.7a98c5b6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014 16:43:25 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> What you're doing in kirkwood-i2s is providing two plain DAI links,
> and then insisting that only one can be active any any one time.
> 
> A DPCM solution provides at least one frontend DAI link and at least
> one backend DAI link.  Your code does not do this.

You know why I did not insert the DPCM code in the kirkwood driver: it
does not work. But, as I tested it end 2013, I still have the code.
Do you want I propose a patch?

> Which bit of "we need to support both I2S and SPDIF" in my previous
> emails was not clear.  Which bit of "We should only support SPDIF
> on the Cubox" was not clear?
> 
> I *fully* acknowledge that we need to support both, but I'm putting
> a _strong_ recommendation to you _with_ technical reasons why we
> should _only_ support SPDIF on the Cubox.

Sorry, I still don't see why only S/PDIF should be supported on the
Cubox. I have both, and both are working on HDMI. I hope someone will
tell me it also works on S/PDIF: there is no reason it could not.

I don't see your technical reasons: you know the constraints of each
protocol I2S and S/PDIF. If you don't want I2S, just don't declare it
in the DT (see my previous mail). You may also note that I did not put
any change relative to the Cubox DT in my patch.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
