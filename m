From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Apr 2013 12:15:39 +0200
Subject: [PATCH RESEND] video: mxsfb: Fix colors display on lower color
 depth
In-Reply-To: <201304221108.17339.jbe@pengutronix.de>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
 <201304221108.17339.jbe@pengutronix.de>
Message-ID: <51750DCB.3060306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juergen,

Le 22/04/2013 11:08, Juergen Beisert a ?crit :
> Hi Maxime,
> 
> Maxime Ripard wrote:
>> The current code always registers as a 32 bits display, and uses the
>> hardware to drop the MSB of each color to abjust to the interface width
>> used by the panel.
>>
>> This results on 18 bits (and probably 16 bits display as well) in colors
>> being displayed poorly, because the MSB are obviously the most important
>> bits for each color definition.
> 
> But the "def_rgb666" bitfield description reports correctly to use bit 0..5 
> for each colour component in this mode. Maybe your userland program has a bug 
> and forgets to honor the bitfield description?

Hmmm, that might be the case actually, yes, I'll check into this and let
you know. Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
