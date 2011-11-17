From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 11:20:13 +0800
Subject: [RFC 1/1] ARM: imx6q: move clock register map to
 machine_desc.map_io
In-Reply-To: <CAMPhdO8vE4cer-EQZ53VDQrZpQ1JVvus2=RpDCfdJRa7gwLUqg@mail.gmail.com>
References: <1321494612-24795-1-git-send-email-richard.zhao@linaro.org>
 <CAMPhdO8vE4cer-EQZ53VDQrZpQ1JVvus2=RpDCfdJRa7gwLUqg@mail.gmail.com>
Message-ID: <20111117032012.GF14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 10:56:53AM +0800, Eric Miao wrote:
> On Thu, Nov 17, 2011 at 9:50 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > If the map is in machine_desc.timer.init, the registers will not be
> > able to access after bootup (probably after "Freeing init memory").
> 
> Given that devicemaps_init() does additional work after creating
> the mapping, flushing TLB and cache, machine_desc->map_io() is
> what I assume the best place for these static IO mappings than
> elsewhere.
> 
> Shawn?
> 
I'm still trying to understand what happened.  I do not understand
how the map can become unusable after "Freeing init memory".  Also
I can not reproduce the problem on my side.

-- 
Regards,
Shawn
