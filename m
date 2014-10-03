From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Oct 2014 10:32:15 +0200
Subject: [PATCH 12/29] ncr5380: Cleanup host info() methods
In-Reply-To: <20141002065631.136827342@telegraphics.com.au>
References: <20141002065628.256592712@telegraphics.com.au>
 <20141002065631.136827342@telegraphics.com.au>
Message-ID: <CAMuHMdXVVvbSqZ1fKqbd3TgjO7ymcOLojhUhXsph-Nn8UUStNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 2, 2014 at 8:56 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> +static void prepare_info(struct Scsi_Host *instance)
> +{
> +       struct NCR5380_hostdata *hostdata = shost_priv(instance);
> +
> +       snprintf(hostdata->info, sizeof(hostdata->info),

[...]

> +                "");
> +       hostdata->info[sizeof(hostdata->info) - 1] = '\0';

snprintf() will make sure the string is zero-terminated, so doing this manually
is not needed.

This applies to all three occurrences.

>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
