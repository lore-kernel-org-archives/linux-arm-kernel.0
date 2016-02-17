From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 10:40:41 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <s5h1t8b65n7.wl-tiwai@suse.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5h8u2j6749.wl-tiwai@suse.de> <s5h1t8b65n7.wl-tiwai@suse.de>
Message-ID: <7110505.tMOluD0MjY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 10:35:40 Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: jack: Allow building the jack layer without
>  input device
> 
> Since the recent integration of kctl jack and input jack layers, we
> can basically build the jack layer even without input devices.  That
> is, the jack layer itself can be built with conditional to enable the
> input device support or not, while the users may enable always
> CONFIG_SND_JACK unconditionally.
> 
> For achieving it, this patch changes the following:
> - A new Kconfig, CONFIG_SND_JACK_INPUT_DEV, was introduced to indicate
>   whether the jack layer supports the input device,
> - A few items in snd_jack struct and relevant codes are conditionally
>   built upon CONFIG_SND_JACK_INPUT_DEV,
> - The users of CONFIG_SND_JACK drop the messy dependency on
>   CONFIG_INPUT.
> 
> This change also automagically fixes a potential bug in HD-audio
> driver Arnd reported, where the NULL or uninitialized jack instance is
> dereferenced.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 

Looks great, that indeed takes care of the issue I reported and
makes the code more useful and more robust overall.

Acked-by: Arnd Bergmann <arnd@arndb.de>
