From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Sep 2015 09:42:48 +0200
Subject: [linux-sunxi] [PATCH 0/2] ASoC: Add support for the Allwinner
 A10 codec
In-Reply-To: <1442928417.6509.12.camel@plaes.org>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442928417.6509.12.camel@plaes.org>
Message-ID: <20150928074248.GI7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Tue, Sep 22, 2015 at 04:26:57PM +0300, Priit Laes wrote:
> On Sat, 2015-09-12 at 15:26 +0200, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > This patch set adds the support for what Allwinner calls the codec on
> > their SoCs.
> > 
> > This codec is actually a combination of a codec and DAI, tied
> > together
> > in a single memory-mapped IP. It is completely standalone, and
> > outputs
> > directly the analog signal.
> > 
> > While it supports both playback and capture, the capture is not
> > implemented in this patch, and will be posted eventually as a
> > separate
> > one.
> > 
> > This set, in order to be functional, has a dependency on the audio
> > clocks patch set posted separately. However, it doesn't needs this to
> > compile properly, so I guess it can be merged without really caring
> > for the merging status of the clock patches.
> 
> It works on Gemei G9 tablet which has also extra chip that
> automatically switches output over from internal speakers to headphones
> when connector is inserted.
> 
> Now I noticed some weird things:
> 
> When I have all the switches as ON in alsamixer, and I start disabling
> them, I get following weird results.
> 
> Left Mixer Left - LML
> Right Mixer Left - LMR
> Right Mixer Right - RMR
> 
> Very faint output:
> LML - ON
> RML - Mute
> RMR - ON
> 
> Output works fully:
> LML - Mute
> RML - Mute
> RMR - Mute
> 
> When I Mute Pre-Amplifier and fiddle any of LML, RML or RMR, the output
> stays mute even after setting Pre-Amplifier Mute back on:
> 
> 1. All switches on
> 2. Mute pre-amplifier
> 3. Mute RMR
> 4. Pre-Amilifier Mute Off
> .. Music stays off
> 5. Toggle Pre-Amplifier twice - output turns on

Unfortunately, I don't have access to that SoC or that setup.

Do you have another A10 board with a simpler audio setup, like a
cubieboard?

> And also following in dmesg:
> sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

That one is weird, I'll look into this.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150928/fc33211d/attachment-0001.sig>
