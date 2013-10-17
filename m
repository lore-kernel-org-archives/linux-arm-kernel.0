From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 17 Oct 2013 13:20:47 -0700
Subject: [PATCH v2] TTY: hvc_dcc: probe for a JTAG connection before
 registering
In-Reply-To: <CAL_JsqK0hPtoD22fw3J+TmgNwJeJUYwjB9i1C4n817GvuOxQxw@mail.gmail.com>
References: <1379968234-23373-1-git-send-email-robherring2@gmail.com>
 <1380074758-19808-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqK0hPtoD22fw3J+TmgNwJeJUYwjB9i1C4n817GvuOxQxw@mail.gmail.com>
Message-ID: <20131017202047.GA24568@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 02:16:37PM -0500, Rob Herring wrote:
> On Tue, Sep 24, 2013 at 9:05 PM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > Enabling the ARM DCC console and using without a JTAG connection will
> > simply hang the system. Since distros like to turn on all options, this
> > is a reoccurring problem to debug. We can do better by checking if
> > anything is attached and handling characters. There is no way to probe
> > this, so send a newline and check that it is handled.
> >
> > Cc: Paolo Pisati <paolo.pisati@canonical.com>
> > Cc: Tim Gardner <tim.gardner@canonical.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.cz>
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> > v2: use time_is_after_jiffies
> >
> >  drivers/tty/hvc/hvc_dcc.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> 
> Greg, Jiri,
> 
> Can you please apply.

I already did, didn't you get an email saying it was applied to my tree?
