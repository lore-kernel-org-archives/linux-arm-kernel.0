From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Fri, 4 Apr 2014 09:58:03 +0200
Subject: [alsa-devel] [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <20140404064932.GC20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
Message-ID: <CAOf5uwkDdsDzRAMHV0e2ideR-R8Tztis1HxqosQAxefVQDE3oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus

On Fri, Apr 4, 2014 at 8:49 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi,
>
> On Thu, Apr 03, 2014 at 11:14:06PM +0100, Mark Brown wrote:
>> On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
>> > Hi,
>> >
>> > This new version of the cleanup is mainly a reordering of the patches. It moves
>> > the regmap patch to the end of the series so none of the other patches depend
>> > on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which also
>> > removed the switching between network and normal mode depending on the number
>> > of channels. I reversed this code removal. Another new patch was added "Fix
>> > i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_fmt().
>>
>> It's been nearly three weeks with no response to this except for the
>> last patch - I've got ahead and applied since it all looks sane (modulo
>> the bugfix question), we can see if problems occur in -next after the
>> merge window.  Thanks!
>
> Thanks for applying this series, but could you please drop it for the
> moment? We found some issues with the baud clock setup for i2s master
> mode and have some fixed patches for the series. So it would be nice to
> get this in without fixups if that's still possible? I could send a v3
> next week.

We have tested a bit them on Wandboard and rebase our patches.
I was busy in the last 2 weeks but they are fine so far.

Michael

>
> Thanks,
>
> Markus
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
