From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Oct 2013 14:25:21 +0000
Subject: [PATCH v2 2/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <CAOQ7t2bkA8K6_d_Sh9Uj2-m005OWR0U4Sz8auBBWhwipnD7QNQ@mail.gmail.com>
References: <1381948227-6290-1-git-send-email-carlo.caione@gmail.com>
 <1381948227-6290-2-git-send-email-carlo.caione@gmail.com>
 <20131022152313.GU3041@lukather>
 <CAOQ7t2bkA8K6_d_Sh9Uj2-m005OWR0U4Sz8auBBWhwipnD7QNQ@mail.gmail.com>
Message-ID: <20131027142521.GB16856@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Sat, Oct 26, 2013 at 11:19:49AM +0200, Carlo Caione wrote:
> On Tue, Oct 22, 2013 at 5:23 PM, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > You never got back to us about this 500ms delay.
> 
> In this case this 500ms sleep is just to avoid reading the time when
> the time (and in the worst case the date) is going to change.
> i.e. you are reading time and date on the last second of the day.

Hmmm, I don't understand how that delay is solving this issue. You're
only deferring this.

> > How does the RTC framework behaves when you register two devices with
> > the same string here?
> 
> Should be safe since rtc_device_register() uses ida_simple_get() to
> get a new id.

Ok.

> >
> > Thanks!
> 
> v3 on its way...

Cool, thanks.
You don't need to resend the DT patch btw, it's already been applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131027/858af91e/attachment.sig>
