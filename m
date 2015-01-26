From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Mon, 26 Jan 2015 15:56:29 +0000
Subject: [PATCH v2] ARM: AM43xx: hwmod: add VPFE hwmod entries
In-Reply-To: <20150126155032.GD2570@ti.com>
References: <1422217915-24231-1-git-send-email-prabhakar.csengg@gmail.com>
 <alpine.DEB.2.02.1501260205090.5450@utopia.booyaka.com>
 <CA+V-a8urS2C20FDcfsGa+Gg+7wmbbQQw3U7BfXf6GBKoBGMc9w@mail.gmail.com>
 <20150126155032.GD2570@ti.com>
Message-ID: <CA+V-a8vuD-+cwaP_bKpB8GweT-xX4E3PHrbB+uefCW+Xre7cog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Mon, Jan 26, 2015 at 3:50 PM, Benoit Parrot <bparrot@ti.com> wrote:
> Lad, Prabhakar <prabhakar.csengg@gmail.com> wrote on Mon [2015-Jan-26 08:13:01 +0000]:
>> Hi Paul,
>>
>> Thanks for the review.
>>
>> On Mon, Jan 26, 2015 at 2:15 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> > Hi
>> >
>> > On Sun, 25 Jan 2015, Lad, Prabhakar wrote:
>> >
>> >> From: Benoit Parrot <bparrot@ti.com>
>> >>
>> >> this patch adds VPFE HWMOD data for AM43xx.
>> >>
>> >> Signed-off-by: Benoit Parrot <bparrot@ti.com>
>> >> Signed-off-by: Darren Etheridge <detheridge@ti.com>
>> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> >> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> >> ---
>> >>  Hi Paul,
>> >>
>> >>  You were right, the hardware team has confirmed that, the VPFE master port is
>> >>  connected to L3 and the VPFE slave port is connected to L4. The L3 port cannot
>> >>  serve as a register target because it is initiator only.
>> >
>> > OK makes sense to me.,
>> >
>> >>
>> >>  I have created links referring to dss l3/l4 hwmod and tested it, lemme know
>> >>  if I have missed something.
>> >
>> > A few minor comments below
>> >
>> >>
>> [Snip]
>> >>  /* Interfaces */
>> >>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
>> >>       .master         = &am33xx_l3_main_hwmod,
>> >> @@ -788,6 +826,36 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
>> >>       .user           = OCP_USER_MPU | OCP_USER_SDMA,
>> >>  };
>> >>
>> >> +static struct omap_hwmod_ocp_if am43xx_l3__vpfe0 = {
>> >> +     .master         = &am43xx_vpfe0_hwmod,
>> >> +     .slave          = &am33xx_l3_main_hwmod,
>> >> +     .clk            = "l3_gclk",
>> >> +     .flags          = OCPIF_SWSUP_IDLE,
>> >
>> > OCPIF_SWSUP_IDLE probably isn't needed here.  Could you please try without
>> > it?
>> >
>> >> +     .user           = OCP_USER_MPU | OCP_USER_SDMA,
>> >> +};
>> >> +
>> >> +static struct omap_hwmod_ocp_if am43xx_l3__vpfe1 = {
>> >> +     .master         = &am43xx_vpfe1_hwmod,
>> >> +     .slave          = &am33xx_l3_main_hwmod,
>> >> +     .clk            = "l3_gclk",
>> >> +     .flags          = OCPIF_SWSUP_IDLE,
>> >
>> > Same point as the above.
>> >
>> Dropped and tested works! posting a v3.
>
> When you tested it without the OCPIF_SWSUP_IDLE, did you go trhough a complete suspend/resume cycle?
> This flag was added early on because otherwise the susbsytem would not go idle without it...
>
> Can you post the console output during a suspend/resume cycle?
>
Ah I didn?t test the suspend/resume will do and post the console log.

Cheers,
--Prabhakar Lad
