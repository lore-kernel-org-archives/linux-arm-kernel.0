From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu, 7 Jul 2016 15:57:36 -0700
Subject: [PATCH v2 3/5] drivers: net: phy: Add MDIO driver
In-Reply-To: <20160707140302.GP19800@lunn.ch>
References: <1464739840-21971-1-git-send-email-isubramanian@apm.com>
 <1464739840-21971-4-git-send-email-isubramanian@apm.com>
 <20160601011148.GD31982@lunn.ch>
 <CAKh23FmaQy8J=f-eyfBeNndz0oT5R0icvwJ3vrw1DMJnj9uv_g@mail.gmail.com>
 <20160705134950.GC5230@lunn.ch>
 <CAKh23FnvgWRMo=M35Mj4=a_KeUpvOoHa8stU=bSk9Y3VSRtyzQ@mail.gmail.com>
 <20160707140302.GP19800@lunn.ch>
Message-ID: <CAKh23Fk2gBwoMxPN5dsV7=y=1zSYfoXRQhq5anTbG61gYf8z7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Jul 7, 2016 at 7:03 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Wed, Jul 06, 2016 at 04:44:44PM -0700, Iyappan Subramanian wrote:
>> Hi Andrew,
>>
>> On Tue, Jul 5, 2016 at 6:49 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > On Mon, Jun 06, 2016 at 10:12:35AM -0700, Iyappan Subramanian wrote:
>> >> Hi Andrew,
>> >>
>> >> Thanks for the review.
>> >>
>> >> On Tue, May 31, 2016 at 6:11 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> > On Tue, May 31, 2016 at 05:10:38PM -0700, Iyappan Subramanian wrote:
>> >> >> +static int xgene_mdio_reset(struct xgene_mdio_pdata *pdata)
>> >> >> +{
>> >> >> +     int ret;
>> >> >> +
>> >> >> +     if (pdata->mdio_id == XGENE_MDIO_RGMII) {
>> >> >> +             if (pdata->dev->of_node) {
>> >> >> +                     clk_prepare_enable(pdata->clk);
>> >> >> +                     clk_disable_unprepare(pdata->clk);
>> >> >> +                     clk_prepare_enable(pdata->clk);
>> >> >
>> >> > Hi Iyappan
>> >> >
>> >> > Is that a workaround for a hardware problem? If so, i would suggest
>> >> > adding a comment, to stop people submitting a patch simplifying it.
>> >>
>> >> Hardware expects this clock sequence.  I'll add comment as you suggested.
>> >
>> > What exactly does the hardware require? Is this a workaround for a bug
>> > in the clock generator? Or a workaround for a bug in the MDIO device?
>>
>> Hardware requires a clock pulse.  There is no bug.
>
> And how are you guaranteeing a pulse? You enable/disable/enable
> without any sleeps, so it could all happen within a single clock
> cycle?

I'll add delay to generate the pulse and resubmit the patch.

>
>         Andrew
