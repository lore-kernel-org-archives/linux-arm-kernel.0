From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jan 2012 10:28:43 +0100
Subject: [RFC PATCH v3 3/5] pinctrl: imx: add pinctrl imx driver
In-Reply-To: <20120110135147.GB26599@S2101-09.ap.freescale.net>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-4-git-send-email-b29396@freescale.com>
 <20120108130542.GC2203@richard-laptop>
 <20120109020848.GF1835@S2101-09.ap.freescale.net>
 <20120109021702.GV2414@b20223-02.ap.freescale.net>
 <20120109063136.GI1835@S2101-09.ap.freescale.net>
 <20120110083842.GA2414@b20223-02.ap.freescale.net>
 <CACRpkdZ=G+=Aq49r9VYa1ZGMg=Sy3Dy3kHNbbcFRp-Hn6y1ZqQ@mail.gmail.com>
 <20120110135147.GB26599@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdbUX-s8hM_Gk=XiwUufAzGz479L_t8vg77ek1KwPCKa_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 2:51 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Jan 10, 2012 at 11:43:28AM +0100, Linus Walleij wrote:
>> What we need to know right now is what you need from the pin
>> controller core to do that. We have a (custom) pinconf API now,
>> does it fit the bill?
>>
> Hmm, I do not think it fits right away, as I do not think it's sensible
> to have pinctrl client drivers call pin_config_set() directly.

OK that's more or less what Stephen said too so I'm cooking a
config table ala pinmux with string identifiers.

>> I have spent some time on generic pin config, it was not much
>> commented so if it helps you please ACK the patches.
>>
> Since the ARM community is the one who is most interested in pinctrl
> subsystem so far, I guess copying LAKML will help collect more comments
> and various tags. ?(For example, I'm interested in pinctrl, but I do
> not track LKML as close as I do for LAKML).

True. I'll fix that.

>> Next from discussions with Stpehen I've sort of figured out that
>> we need a config mapping table of sorts and then a means to activate
>> entries of that table at runtime. I'm trying to come up with something
>> for this.
>>
> That's something we are waiting for pinconf being usable for imx.

I'll fix something, please review when it appears!

Thanks,
Linus Walleij
