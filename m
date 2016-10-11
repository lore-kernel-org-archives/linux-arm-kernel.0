From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Oct 2016 17:16:21 +0800
Subject: [PATCH 2/9] drm/sun4i: tcon: Move SoC specific quirks to a DT
 matched data structure
In-Reply-To: <20161007083853.GH4684@lukather>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-3-wens@csie.org>
 <20161007083853.GH4684@lukather>
Message-ID: <CAGb2v67vZLCtUOaqBwtAnHmCMpoxmh3pxjtD5TL2nWp3Lm-Pzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 7, 2016 at 4:38 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Oct 07, 2016 at 12:06:22AM +0800, Chen-Yu Tsai wrote:
>> +struct sun4i_tcon_quirks {
>> +     bool    is_sun5i;       /* sun5i has undocumented mux */
>> +     bool    has_channel_1;  /* a33 does not have channel 1 */
>> +     bool    has_bypass_src; /* has separate input bypassing CEU */
>> +     bool    has_dma_src;    /* has DMA input */
>> +};
>> +
>
> I'd really prefer to keep the has_mux quirk name. is_sun5i doesn't
> really relate to what we're doing there, is redundant with the
> compatible, and render the other quirks name useless, since we could
> just have is_sun.i quirks and deal with that (which is essentially
> what we were doing before).

Lets call it has_unknown_mux then. has_mux would be confusing with
the HDMI and MIPI DSI muxes on sun6i.

ChenYu
