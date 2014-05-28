From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 28 May 2014 13:30:01 -0700
Subject: [PATCH 0/6] DT early console initialization
In-Reply-To: <CAL_JsqK9nifPWW5jnzYifsMuvRjhD9wTT+YbE0sPM6N4xaj1yA@mail.gmail.com>
References: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
 <20140514142644.1C922C4153D@trevor.secretlab.ca>
 <CAL_JsqK9nifPWW5jnzYifsMuvRjhD9wTT+YbE0sPM6N4xaj1yA@mail.gmail.com>
Message-ID: <20140528203001.GA14334@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 11:30:04AM -0500, Rob Herring wrote:
> On Wed, May 14, 2014 at 9:26 AM, Grant Likely <grant.likely@linaro.org> wrote:
> > On Thu,  8 May 2014 17:23:37 -0500, Rob Herring <robherring2@gmail.com> wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> This series adds support for early serial console initialization using
> >> DT. This enables determining the serial port type and address using the
> >> FDT and allows enabling the console before platform specific
> >> initialization runs. I've tested this on arm64. ARM support is dependent
> >> on adding fixmap support.
> >>
> >> Currently, the earlycon is only enabled if "earlycon" is present on the
> >> kernel command line. The FDT needs to have /chosen/stdout-path set to
> >> the path of the serial port.
> >>
> >> This series is dependent on generic earlycon[1], libfdt support[2], and
> >> vmlinux.lds.h clean-ups[3]. The first 2 are in linux-next already. A git
> >> branch is available here:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git earlycon-dt
> >
> > Nice. For the whole series:
> >
> > Acked-by: Grant Likely <grant.likely@linaro.org>
> >
> > I haven't tested it though.
> >>
> >> Rob
> >>
> >> [1] https://lkml.org/lkml/2014/4/18/573
> >> [2] https://lkml.org/lkml/2014/4/22/1202
> >> [3] https://lkml.org/lkml/2014/3/27/285
> >>
> >> Rob Herring (6):
> >>   of: align RESERVEDMEM_OF_DECLARE function callbacks to other callbacks
> >>   of: consolidate linker section OF match table declarations
> >>   serial: earlycon: add DT support
> >>   of/fdt: add FDT address translation support
> >>   of/fdt: add FDT serial scanning for earlycon
> >>   tty/serial: pl011: add DT based earlycon support
> 
> Greg, I plan to take this series thru the DT tree for 3.16 unless you
> have any objections. It has dependencies on both the tty-next and the
> DT trees.

No objection from me at all, feel free to do so.

greg k-h
