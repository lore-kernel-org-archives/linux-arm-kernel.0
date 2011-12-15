From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 15 Dec 2011 17:10:57 +0000
Subject: [PATCH] arm,davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <CAPcSpELkWJpP9-3UoNHF_aWSdd_b0FHNooNm+zF7UTjHEBC_vg@mail.gmail.com>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <4EE07E27.8090602@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6040CBB@DBDE01.ent.ti.com>
 <201112081548.08548.arnd@arndb.de>
 <DF0F476B391FA8409C78302C7BA518B60471C1@DBDE01.ent.ti.com>
 <CAPcSpELkWJpP9-3UoNHF_aWSdd_b0FHNooNm+zF7UTjHEBC_vg@mail.gmail.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B604A17B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wed, Dec 14, 2011 at 20:05:25, Ben Gardiner wrote:
> Hello Arnd and Sekhar,
> 
> On Tue, Dec 13, 2011 at 1:34 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
> > [...]
> > On Thu, Dec 08, 2011 at 21:18:08, Arnd Bergmann wrote:
> >> [...]
> >> If you want it to provide endpoint devices that are handled by
> >> distinct subsystems in Linux, I would make it an mfd multifunction
> >> device and make the common code a driver that scans the connected
> >> memories in order to register its child devices for each of the
> >> subsystems.
> >
> > Okay. Thanks for the explanation. Since the users of AEMIF at this
> > point are mtd devices, I propose moving it to drivers/mtd/davinci-aemif.c
> > (of course, mtd folks need to approve).
> 
> We have a vested interest in the davinci AEMIF setup facilities
> in-kernel; I'm electing to pipe-up now rather than later. Sadly our
> board is not yet in mainline so my opinions may be redirected to the
> bit-bucket as you see fit. We are planning to post a patch series for
> our complete board support -- but we can't do it right now.
> 
> The AEMIF is useful for interfacing to other asynchronous devices too;
> our newest board uses it for accessing memory mapped FPGA functional
> blocks via UIO and for permanent storage to a compact flash using
> pata_platform. In both cases the timings and mode for the chip-select
> are manually configured before the devices are registered. In both
> cases the performance of the endpoints could be better preserved
> across CPU freq transitions if the hooks for cpufreq transitions
> recently proposed by Sudhakar [1] were part of an mfd device and hence
> applicable to devices other than mtd.
> 
> Again, I apologize for requesting features for boards that are not yet
> in mainline.

No problem. Thanks for showing a use case I didn't know existed.
Now we just need to find someone to work on moving aemif to mfd
multifunction device :)

Thanks,
Sekhar
