From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 3 May 2014 18:07:31 -0400
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
Message-ID: <20140503220731.GA10927@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:20:53PM -0500, Rob Herring wrote:
> On Sat, Apr 26, 2014 at 1:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Fri, Apr 18, 2014 at 3:19 PM, Rob Herring <robherring2@gmail.com> wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> With the generic earlycon infrastructure in place, convert the 8250
> >> early console to use it.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Jiri Slaby <jslaby@suse.cz>
> >> ---
> >>  drivers/tty/serial/8250/8250_early.c | 138 ++++-------------------------------
> >>  drivers/tty/serial/8250/Kconfig      |   1 +
> >>  2 files changed, 16 insertions(+), 123 deletions(-)
> >
> > Hi Greg, Rob
> >
> > This one in tty-next breaks booting: "console=uart8250,io,0x3f8,115200".
> > No early console and regular console anymore.
> >
> > It should produce "early con and regular con".
> 
> This is what I get for running checkpatch and converting
> simple_strtoul to kstrto* which are not so equivalent. kstrto* will
> not convert things such as 115200n8 to a number.
> 
> Greg, Do you want a fix or for me to respin the series? The fix looks like this:

As this is in my tree now (right?), I need a fix to apply to it.

thanks,

greg k-h
