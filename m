From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:49:04 +0100
Subject: [PATCH v2 06/10] ASoC: sun8i-codec-analog: Add amplifier event
 to fix first delay
In-Reply-To: <20170117140230.23142-7-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-7-mylene.josserand@free-electrons.com>
Message-ID: <20170117164904.c22f7tmtu67l23dd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:02:26PM +0100, Myl?ne Josserand wrote:
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

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/b6afa6d0/attachment.sig>
