From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 4 Nov 2010 11:52:10 +0200
Subject: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
	file
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
Message-ID: <AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 4, 2010 at 3:02 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>> -----Original Message-----
>> From: Grazvydas Ignotas [mailto:notasas at gmail.com]
>> Sent: Wednesday, November 03, 2010 6:33 PM
>> To: Ghorai, Sukumar
>> Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
>> kernel at lists.infradead.org; Vimal Singh; Artem.Bityutskiy at nokia.com
>> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from
>> board file
>>
>> On Mon, Sep 27, 2010 at 5:11 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote:
>> > This patch makes it possible to select sw or hw (different layout
>> options)
>> > ecc scheme supported by omap nand driver. ?And hw ecc layout selected
>> for
>> > sdp and zoom boards, by default.
>> >
>> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
>>
>> Any news on this? Commit 2c01946c accidentally (?) enabled hardware
>> ECC and now my board is broken, as the driver always used sw ecc and
>> my NAND partitions are formatted accordingly. We should at least
>> switch the default back to sw ecc, don't you think?
> [Ghorai]
> 1. which board you are working.
> 2. and the default layout is the same as previous
> + ? ? ? board_nand_data.ecc_opt ? ? ? ? = OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;

OMAP3 pandora.
What I wanted to say is that current mainline code has hw ECC forced
which is wrong for some boards, and this patch did not make into last
merge window, so NAND is broken. It would be good to take this patch
out of larger series you sent earlier and resend as a fix for -rc1, so
that NAND works on 2.6.37.  It's not too large and should probably be
ok for -rc2.
