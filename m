From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Feb 2017 14:08:54 +0800
Subject: [PATCH v4 4/8] ASoC: sun8i-codec-analog: Add amplifier event to
 fix first delay
In-Reply-To: <20170202092422.5588-5-mylene.josserand@free-electrons.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
 <20170202092422.5588-5-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 5:24 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> When playing a sound for the first time, a short delay, where the audio
> file is not played, can be noticed.
> On a second play (right after), the sound is played correctly.
> If we wait a short time (~5 sec which corresponds to the aplay
> timeout), the delay is back.
>
> This patch fixes it by using an event on headphone amplifier.
> It allows to keep the amplifier enable while playing a sound.
> A delay of 700ms allows to wait that the amplifier is powered-up
> before playing the sound.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I get some static in my headphones in the time between when the
amplifier is enabled and when sound starts playing. Wonder if
this can be fixed in any way?

One solution that might work is to mute the headphone output
while the amp is being charged, by setting SUN8I_ADDA_HP_VOLC_HP_VOL
to 0, and then restoring the value once it is charged. In other
words, overriding the value for the duration of sun8i_headphone_amp_event.

Regards
ChenYu
