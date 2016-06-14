From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Jun 2016 17:45:57 -0700
Subject: [PATCH 09/11] phy: rockchip-emmc: Set phyctrl_frqsel based on
 card clock
In-Reply-To: <036b0349-8343-f5de-7215-5a0843ebc6a9@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-10-git-send-email-dianders@chromium.org>
 <937cbbc5-f9dc-bdf0-c46a-c7e814b9b373@rock-chips.com>
 <CAD=FV=VA6vmfzHEOZwAFJvNXRDhPmf+bX-Jw1eFboOdP6kD3dg@mail.gmail.com>
 <036b0349-8343-f5de-7215-5a0843ebc6a9@rock-chips.com>
Message-ID: <CAD=FV=VN-sNSjkZp_BTEn=uCdOmdTLk7+5AvF8U+7j908Ynycw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Jun 13, 2016 at 5:24 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> From the public Arasan datasheet they seem to indicate +/- 15 MHz is
>>
>> sane.  Does that sound OK?  Presuming that all of your numbers
>> (50/100/150/200) are centers, that means that we could support clock
>> rates of:
>>
>> 35 MHz - 65 MHz
>> 85 MHz - 115 MHz
>> 135 MHz - 165 MHz
>> 185 MHz - 200 MHz
>>
>>
>> So how about if we add a warning for things that are outside of those
>> ranges?  ...except no warning for < 35 MHz since presumably we're not
>> using high speed modes when the DLL is that slow and so we're OK.
>
>
> a warning should be ok.
> If we ask 150M, but PLL only provide 175M maybe, then should we
> fallback it to 150M or promote it to 200M when setting?

I made it a warning in V2 but still picked the closest reasonable
value.  See what you think.  The PHY really isn't in control of this
clock, so the warning is the best it can do.  Presumably someone
designing a system with this PHY in it would see the warning an
realize that they should make SDHCI run at more reasonable rates...

-Doug
