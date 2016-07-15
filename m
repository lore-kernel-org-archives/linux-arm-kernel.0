From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 15 Jul 2016 15:07:08 +0200
Subject: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <1809117.TV1VJp2Xpr@vostro.rjw.lan>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <CADyBb7tkk5DhG_1_87+BQKQfF-CSC+LgP7LE=9SmztvaFLxNyQ@mail.gmail.com>
 <1809117.TV1VJp2Xpr@vostro.rjw.lan>
Message-ID: <5101961.eCg7ixLQWc@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 15, 2016 02:15:27 PM Rafael J. Wysocki wrote:
> On Friday, July 15, 2016 03:32:35 PM Fu Wei wrote:
> > Hi Rafael,
> > 

[cut]

> > >
> > >> +               return 0;
> > >> +       }
> > >> +
> > >> +       if (!gtdt->platform_timer_count) {
> > >> +               pr_info("No Platform Timer.\n");
> > >> +               return 0;
> > >> +       }
> > >> +
> > >> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
> > >> +                                             gtdt->platform_timer_offset;
> > >> +       if (acpi_gtdt_desc.platform_timer_start <
> > >> +           (void *)table + sizeof(struct acpi_table_gtdt)) {
> > >> +               pr_err(FW_BUG "Platform Timer pointer error.\n");
> > >
> > > Why pr_err()?
> > 
> > if (true), that means the GTDT table has bugs.
> > 
> 
> And that's not a very useful piece of information unless you're debugging the
> platform, is it?

FWIW, I'm not a big fan of printing "your firmware is buggy" type of messages
(especially at the "error" log level or higher) unless they can be clearly
connected to a specific type of functional failure.

So if you want to pring an error-level message, something like "I cannot do X
because of the firmware bug Y" would be better IMO.

Thanks,
Rafael
