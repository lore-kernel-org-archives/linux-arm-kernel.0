From: carlo.caione@gmail.com (Carlo Caione)
Date: Sat, 26 Oct 2013 11:19:49 +0200
Subject: [PATCH v2 2/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <20131022152313.GU3041@lukather>
References: <1381948227-6290-1-git-send-email-carlo.caione@gmail.com>
 <1381948227-6290-2-git-send-email-carlo.caione@gmail.com>
 <20131022152313.GU3041@lukather>
Message-ID: <CAOQ7t2bkA8K6_d_Sh9Uj2-m005OWR0U4Sz8auBBWhwipnD7QNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 5:23 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,
>
> What's the unit of that offset, and what does it apply on ?
> It doesn't look like a register offset, or a year offset like said in
> your comments a few lines above.

The "data year offset" is to be intended as, indeed, a year offset,
not a register offset.
I'll clarify the comment.

> Please use either alarm or alrm, but make up your mind.

ops ... I'll correct it

> Multi-line comments should be
> /*
>  * Like...
>  * this.
>  */

got it

> You never got back to us about this 500ms delay.

In this case this 500ms sleep is just to avoid reading the time when
the time (and in the worst case the date) is going to change.
i.e. you are reading time and date on the last second of the day.

> How does the RTC framework behaves when you register two devices with
> the same string here?

Should be safe since rtc_device_register() uses ida_simple_get() to
get a new id.

>
> Thanks!

v3 on its way...

--
Carlo Caione
