From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 5 Nov 2015 12:42:33 -0300
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <20151105151559.GA16666@lunn.ch>
References: <563B3749.50701@free.fr>
	<20151105151559.GA16666@lunn.ch>
Message-ID: <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 5, 2015 at 12:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Since I don't have time to rewrite the drivers at the moment, I'm wondering
>> if it's possible to "graft" old drivers (they're using the platform API, no
>> trace of DT support) onto my small base?
>
> Platform drivers are still usable with DT systems. We used that fact
> when converting platform based machines over to DT, one driver at a
> time. Look in the git history for kirkwood devices. e.g. somewhere
> around v3.7, arch/arm/mach-kirkwood. board-dt.c, and the various
> board-*.c files, and the DT files in the usual place.
>

OMAP did the same and still some boards use platform data and manually
register platform devices from board code. Take a look to
arch/arm/mach-omap2/pdata-quirks.c to see how that is being done.

Best regards,
Javier
