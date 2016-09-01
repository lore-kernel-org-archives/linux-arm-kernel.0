From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Thu, 1 Sep 2016 12:56:08 +0200
Subject: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In, Mic 2,
 Capture Source, Differential Line-In.
In-Reply-To: <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-3-dannym@scratchpost.org>
 <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
Message-ID: <20160901125608.72808fac@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

> I have a few patches that introduce SOC_DAPM_DOUBLE, so you can share a
> control between left/right channels. IMHO it makes the userspace mixer
> less confusing.

I definitely agree that cutting down on the number of sliders would be good.
I do a double-take every time I open alsamixer - and I *added* these
sun4i widgets :)

It would be good if your patch series was queued and I could use SOC_DAPM_DOUBLE
in a future version of my patch. 

Can you post it?

Since it changes user space-visible API whether I group the widgets or not we
have to be careful about it. So far my patch has not been merged which is good
for API stability I guess.

I wondered about why there's a SOC_DOUBLE_TLV but no SOC_DAPM_DOUBLE before,
so it's good to know there's no deep reason.

That said, I'd have to remove the distinction between Left Mixer and Right
Mixer then. Right now it does distinguish. 

Removing the distinction would remove noteworthy routes like

        { "Right Mixer", "Left DAC Playback Switch", "Left DAC" },

(not a typo). Would that be OK?

Well, let's see how it will work out.

In the mean time I added the second regmap and the quirks and will post another
patch series for comments.

Cheers,
   Danny
