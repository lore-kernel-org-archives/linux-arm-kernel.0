From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Nov 2018 20:18:33 +0100
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <154178275324.88331.16237880990995819011@swboyd.mtv.corp.google.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
 <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com>
 <154178275324.88331.16237880990995819011@swboyd.mtv.corp.google.com>
Message-ID: <CAMuHMdXTTCo6Fsr9eYstT6AFLOQ-_sKkhjw7cP8XdFabVqdJWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Nov 9, 2018 at 5:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-11-09 01:56:01)
> > On Wed, Nov 7, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Rob Herring (2018-11-06 12:44:52)
> > > > On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >         int (*probe)(struct platform_device *pdev);
> > >   };
> > >
> > >   struct of_platform_driver_probe_func mtk_probes[] = {
> > >         mtk_probe1,
> > >         mtk_probe2,
> > >         mtk_probe3,
> > >   };
> > >
> > >   struct platform_driver mtk_driver = {
> > >         .of_probes = &mtk_probes;
> > >         .driver = {
> > >                 .name = "mtk-foo";
> > >                 .of_match_table = mtk_match_table,
> > >         },
> > >   };
> >
> > This looks worse to me: people tend to be very good at keeping multiple
> > arrays in sync :-(
>
> To be _not_ very good? Agreed, and so specifying the probe function as
> another member in struct of_device_id seems to be the way to go.

Correct, sometimes sarcasm doesn't arrive well at the other end of the
electronic tunnel...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
