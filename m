From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 23:50:27 +0200
Subject: [PATCH] ARM: supply a DTB file to be appended
In-Reply-To: <20110908163209.GB22308@ponder.secretlab.ca>
References: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
	<20110908163209.GB22308@ponder.secretlab.ca>
Message-ID: <CACRpkdYU=Xy30waqqBWfoQ86Ap39v613=22sYQtGzoUJg1OV1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 6:32 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Sep 08, 2011 at 12:14:44PM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>> This adds a Kconfig string where you can specify a
>> file to be appended to the zImage on build, then
>> auto-appends it. The idea is to mimic how we supply
>> an initramfs image by a similar parameter.
>
> The other option is to encode the .dtb filename into the zImage target
> name (something like zImage.%). ?The advantage being that the build
> can emit multiple .dtb bound images without changing the kernel
> config. ?This is what PowerPC currently does.

Then "make uimage" has to emit uImage.% as well I guess.

I could do that, but it appears Nico don't like making this too
easy to do so I'll just keep it around as some out-of-tree patch
for personal playground.

Thanks,
Linus Walleij
