From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2011 13:23:39 +0200
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <8ya62o9fey7.fsf@huya.qualcomm.com>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121051380.2142@xanadu.home>
	<8ya62o9fey7.fsf@huya.qualcomm.com>
Message-ID: <CACRpkdaZwx3v9xyt8YVo+NJY5fbA=ERjhi_DwD-7Xpj_Wnoz8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 2:13 AM, David Brown <davidb@codeaurora.org> wrote:
> On Sun, Jun 12 2011, Nicolas Pitre wrote:
>
>> It is not pointless. ?Never it was in the cards to convert old platforms
>> first. ?The most problematic platforms responsible for the high volume
>> of changes that has gone in mainline lately are the modern ones, not PXA
>> based ones. ?So DT is going to be most effective for the new stuff to
>> come. ?And realistically that's where we might get developers attention,
>> not with those platforms being end-of-lived by their manufacturers.
>
> New stuff doesn't necessarily mean new boot loaders. ?I don't have a lot
> of control over the bootloaders on MSM. ?We can probably move away from
> ATAGS, but only after every kernel that could possibly boot on that
> target will work with DT. ?I don't see that happening for at least a
> year.

Having now inspected the situation with Ux500 I can second that this
goes for the Ux500 series as well.

The U8500 firstcomer in this series and probably U5500 also is
relying on a 2009-based fork of U-boot. The U-boot for these
platforms just won't be converted to do DT.

In short we also need the ATAGs-overrides-DT-nodes approach
for a clean migration path.

Yours,
Linus Walleij
