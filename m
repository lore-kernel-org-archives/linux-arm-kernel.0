From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Sun, 8 Jul 2012 14:44:17 +0530
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <20120705184736.GW30009@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <CAM=Q2csv3rEs-xseGd6NHxR3wRSZp82ZqNB1mn-_C4=5=nOc6g@mail.gmail.com>
 <20120705184736.GW30009@pengutronix.de>
Message-ID: <CAM=Q2cuv3hWyTea+MYzs84xjxhrj9K57kgV2EP-wF9ywLCSKCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 12:17 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Jul 05, 2012 at 11:36:27PM +0530, Shubhrajyoti Datta wrote:
>> On Thu, Jul 5, 2012 at 6:40 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > Measurements on i.MX1 and i.MX53 have shown that the divider values
>> > in the datasheets are wrong.
>> How were the measurements made?
>
> With an oscilloscope measuring the period length. This is probably not
> very exact, but the current values are way off. We had 350KHz instead
> of 380KHz (best possible divider) on an i.MX53. Funny enough some
> divider values really match the ones in the datasheet.
>
> BTW I'm pretty sure the input frequency to the core is calculated
> correctly as it's the same clock that also drives the timer.

OK thanks for the explanation.

>
>>
>> > the values from first, third and fourth
>> > column were all measured to be 8 higher than in the datasheet. It
>> > should be safe to assume that the SoCs between i.MX1 and i.MX53 behave
>> > the same as the i2c unit is unchanged since the i.MX1.
>>
>> Also does it vary board to board or is fixed by the ip?
>> What I mean is that the external cap etc.
>
> The clock is derived from an internal SoC clock, I don't think this can
> be influenced that much by external components. I did not test different
> boards, but two board with different SoCs.

OK thanks.
>
> Let's see what the IC guys tell us.

Sure.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
