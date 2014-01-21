From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Jan 2014 14:32:50 +0100
Subject: [PATCH 4/5 v3] input: tc3589x-keypad: support probing from device
 tree
In-Reply-To: <CACRpkdZW-Nay-wOywq4SG1bwQf_+J4tqYuS=tQmzTHOtBskGVw@mail.gmail.com>
References: <1384270261-15889-1-git-send-email-linus.walleij@linaro.org>
 <20131126023431.GC31517@core.coreip.homeip.net>
 <CACRpkdZW-Nay-wOywq4SG1bwQf_+J4tqYuS=tQmzTHOtBskGVw@mail.gmail.com>
Message-ID: <CACRpkdab32Cfj73D5zyVLDr9JTsQ2xxS3kDKjTBi4f+vLtZMAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 2:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Nov 26, 2013 at 3:34 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Nov 12, 2013 at 04:31:01PM +0100, Linus Walleij wrote:
>>>       irq = platform_get_irq(pdev, 0);
>>> --
>>
>> Don't you also want to add MODULE_DEVICE_TABLE entry?
>
> Probably, but that'd be a separate subject though, I think?
> I'll make a patch for this so you get something you can
> actually merge.

No, wait, this driver only matches on driver name, it has no
match table of any kind. This is typical for MFD-spun cells
if they don't need additional info from the compat match.
I think it only needs the MODULE_ALIAS() it already
has.

Yours,
Linus Walleij
