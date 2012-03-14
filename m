From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Mar 2012 23:18:44 +0100 (CET)
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zNj8eC+h-S9KqwuAEiGFZMAn2h0TNTR6nund4qM7Z97ug@mail.gmail.com>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-4-git-send-email-mturquette@linaro.org>
 <20120313112447.GA29317@pengutronix.de>
 <CAJOA=zMTY+4dU9VUa-TkEbdE-WJd7V4tCG-af6vgq0CPN6rWpg@mail.gmail.com>
 <20120314084857.GL3852@pengutronix.de>
 <CAJOA=zMsCuZgmp1Hm0dq=EVoX6Zj62XQVqR=6GzDntSD5HnHzg@mail.gmail.com>
 <alpine.LFD.2.02.1203142218320.2466@ionos>
 <CAJOA=zNj8eC+h-S9KqwuAEiGFZMAn2h0TNTR6nund4qM7Z97ug@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203142317280.2466@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012, Turquette, Mike wrote:
> On Wed, Mar 14, 2012 at 2:28 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > So the right way to deal with it is to have an array of valid names
> > with no holes and NULL pointers allowed and have a mapping from the
> > array index to the register value.
> 
> This is essentially what the .set_rate callback does.  It takes as
> input "u8 index" and peforms the hardware specific magic to select the
> correct parent clock.  This might be a register write using that exact
> same index, or it might be a single-bit register write using that
> index as the shift value, or it might translate that index into the
> data sent to an i2c device (where the address would be stored in
> struct clk_foo), etc etc.
> 
> We both agree that .parent_names must contain valid names and should
> not have holes.  What I don't understand is if you are saying that we
> should allow NULL ptrs as names; that seems contradictory but I want
> to make sure I'm reading you correctly.

I should have said: no holes and no NULL pointers, just an array of
valid names.

Thanks,

	tglx
