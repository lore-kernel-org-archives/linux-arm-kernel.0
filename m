From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:36:48 +0000
Subject: [PATCH v2 20/28] drm/i2c: tda998x: move the TBG_CNTRL_0
 register setting
In-Reply-To: <20140109120607.6a33bee5@armhf>
References: <20140109120607.6a33bee5@armhf>
Message-ID: <20140111183648.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:06:07PM +0100, Jean-Francois Moine wrote:
> According to the comment, the TBG_CNTRL_0 register must be set at the
> end of the mode change sequence.

So you believe comments without understanding the history, and you move
code around due to those.

No, this is again wrong.  That write to REG_TBG_CNTRL_0 in the sequence
writing the video information to the chip.  This doesn't encompass the
HDMI/DVI mode setting nor the audio configuration - the audio configuration
can change independently of the video setting, and does not require this
register to be written.

This also brings up a bug in one of your previous patches which I now
must go back and comment upon.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
