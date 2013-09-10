From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 10 Sep 2013 08:15:33 -0700
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
In-Reply-To: <20130910150512.GI5815@S2101-09.ap.freescale.net>
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
 <20130909150823.GB5815@S2101-09.ap.freescale.net>
 <CAOMZO5Ab9qVsQica-x3091YPhttqpbr_NL=A2ddzL5znuDtAUw@mail.gmail.com>
 <CAOCHtYhJjxBL1AY0dxc+FofXqRT25g8yaO+Z6d09mfkJWT+i+A@mail.gmail.com>
 <CAOMZO5D8VW=M_DW69p+p512Uw9eySt+PoM-iWN=m3jXb0tfvaw@mail.gmail.com>
 <877geohh6r.fsf@linaro.org>
 <20130910150512.GI5815@S2101-09.ap.freescale.net>
Message-ID: <CAGa+x84egvrdEPebTt3U=1GHpKSoAKHKs14P0ys6+21KhwT9Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 8:05 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Sep 10, 2013 at 07:42:04AM -0700, Kevin Hilman wrote:
>> Fabio Estevam <festevam@gmail.com> writes:
>>
>> > On Mon, Sep 9, 2013 at 1:19 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
>> >
>> >>> Ok, I made this test and it booted fine.
>> >>>
>> >>> So I will change U-boot so that it searches for imx6dl-wandboard.dtb
>> >>> instead of imx6s-wandboard.dtb.
>> >>
>> >> Since there is no WiFi/Bluetooth on the "solo" vs the wandboard dual
>> >> lite, we should really still have a separate solo dtb file..
>> >
>> > I think we could still represent the im6solo-wandboard using the
>> > imx6dl-wandboard.dts.
>> >
>> > In the case of lack of bcm4329 populated on a mx6solo board, the SDHC3
>> > port will just not probe bcm4329 without any negative effect, right?
>>
>> I've noticed in my auto build/boot[1] that booting a wandboard solo with
>> imx6dl-wandboard.dtb actually faults[2].  Just disabling usdhc2[3] makes
>> it boot fine.
>>
>> This only happens on current linus/HEAD.  v3.11 boots fine as does
>> linux-next (as of next-20130910.)
>
> It may be because commit 2af502c (mmc: sdhci: request irq after
> sdhci_init() is called) which is on linux-next right now hasn't landed
> on mainline yet.

Yup, linus/HEAD + that commit makes things work again.  Thanks.

Kevin
