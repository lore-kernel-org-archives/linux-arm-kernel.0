From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 May 2013 10:41:47 -0300
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <201305221219.43558.jbe@pengutronix.de>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
 <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
 <201305221219.43558.jbe@pengutronix.de>
Message-ID: <CAOMZO5Cd19Jx0sXdD55hat579E9CsPqWEKS-FQfVz5LMmuvXjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juergen,

On Wed, May 22, 2013 at 7:19 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
> Hi Fabio,
>
>> i2c slowness is a different issue.
>
> Same happens here for my i.M23 based platform. It seems the PIO mode does not
> work, or at least not like it works on a i.MX28. Each short transfer needs
> about one second (without an error message) but does not send anything on the
> I2C lines.
>
> I need the following patches to make I2C master work within a 3.10-rc2 kernel:

Thanks, I tried forcing dma mode and I got the following probe issue
on a mx28evk running today's linux-next:

[    6.403193] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
[    6.412175] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)
[    6.425582] platform sound.12: Driver mxs-sgtl5000 requests probe deferral
[    6.434043]  mmcblk0: p1 p2 p3
[    6.439586] stmp3xxx-rtc 80056000.rtc: setting system clock to
2013-04-23 21:00:42 UTC (1366750842)
[    6.458141] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
[    6.464773] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)

If I run linux-next with 2f769432d8554 reverted then I get a 23
seconds delay in the probe (1 second for each sgtl5000 register
write).

Regards,

Fabio Estevam
