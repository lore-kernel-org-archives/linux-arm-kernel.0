From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 14:38:48 +0100
Subject: [PATCH v3] ARM: dts: cubox-i: add support for Broadcom
 Wifi/Bluetooth devices
In-Reply-To: <CALHpu35HB4NgtSwc8zJBffrfsD0Kk9++_5kw4K_j2FuUf9sCzQ@mail.gmail.com>
References: <1431358713-12379-1-git-send-email-fabio.estevam@freescale.com>
 <20150518113400.GE1071@dragon>
 <20150518115520.GW2067@n2100.arm.linux.org.uk>
 <20150518121017.GB1418@dragon>
 <CALHpu36rJuRWum+TGrM4cchKLxSVVup0cB58dFxANF=mAzLA0Q@mail.gmail.com>
 <CALHpu35HB4NgtSwc8zJBffrfsD0Kk9++_5kw4K_j2FuUf9sCzQ@mail.gmail.com>
Message-ID: <20150518133848.GX2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 02:47:32PM +0200, Jon Nettleton wrote:
> okay tested.  Looks good on both the 4330 and 4329.
> 
> Signed-off-by: Jon Nettleton <jon@solid-run.com>

Seems to work on the 4329 on the Cubox-i4, although I see an additional
error which didn't appear first time with my original patches:

brcmfmac: brcmf_setup_wiphybands: rxchain error (-52)

It seems to be repeatable, and I'm guessing from a brief look at the code
that "rxchain" is something that's requested from the firmware (my 4329
firmware is v4.220.48).  Why it didn't appear first time around I've no
idea.

Apart from that, iw dev wlan0 scan appears to find my local hostap, and
as usual none of the BTHub stuff that have flooded the area.

I'll drop my patches in favour of this one.  Shawn, please go ahead and
merge it.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
