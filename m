From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 16 Feb 2012 14:13:12 +0530
Subject: [PATCHv2 7/8] arm: omap: clockdomain: add support for preventing
 domain transitions
In-Reply-To: <1329381549.4102.381.camel@sokoban>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-8-git-send-email-t-kristo@ti.com> <87vcn799g8.fsf@ti.com>
 <1329381549.4102.381.camel@sokoban>
Message-ID: <CAMQu2gwjfBd2ybKhEj+1Y1+b4yT+9i-DomozuxCMpKgcSfm9Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero,
On Thu, Feb 16, 2012 at 2:09 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-02-15 at 11:35 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> > Some clockdomains can't support manual domain transitions triggered by
>> > clock framework, and must be prevented from doing so. Added clkdm flag
>> > CLKDM_NO_MANUAL_TRANS for doing this.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>> > Cc: Kevin Hilman <khilman@ti.com>
>>
>> Dumb Q: what's the difference between this new flag and CLKDM_CAN_SWSUP?
>
> CAN_SWSUP controls software wakeup / sleep (clktrctrl values 1 and 2),
> but it still allows hwsup based transitions during runtime (basically
> using values 0 & 3 for the same register.) NO_MANUAL_TRANS prevents
> both, but still allows hwauto mode being enabled in the first place.
>
> I was thinking about adding a flag for preventing the autodep disabling
> as this was the root cause for the problem I saw, but I wanted to
> optimize the _clkdm_clk_hwmod_enable/disable for this case, as the
> domain is not going through any transitions.
>
Which clock-domain you are refering here which needs this
flag ?

Regards
santosh
