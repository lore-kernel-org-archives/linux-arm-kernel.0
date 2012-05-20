From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 20 May 2012 00:00:02 -0600
Subject: [PATCH v2] gpio/generic: initialize basic_mmio_gpio shadow
 variables properly
In-Reply-To: <20120520021009.GA5810@S2100-06.ap.freescale.net>
References: <1337417751-24848-1-git-send-email-shawn.guo@linaro.org>
 <20120519181242.B87193E03B8@localhost>
 <20120520021009.GA5810@S2100-06.ap.freescale.net>
Message-ID: <CACxGe6v4omSoBJKePr4MgYvuQ3bQkYt2EcLF1BZBzMSewbkNyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 8:10 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Sat, May 19, 2012 at 12:12:42PM -0600, Grant Likely wrote:
>> On Sat, 19 May 2012 16:55:51 +0800, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > It fixes the issue in gpio-generic that commit fb14921 (gpio/mxc: add
>> > missing initialization of basic_mmio_gpio shadow variables) manged to
>> > fix in gpio-mxc driver, so that other platform specific drivers do not
>> > suffer from the same problem over and over again.
>> >
>> > Changes since v1:
>> > * Turn the last parameter "bool big_endian" into "unsigned long flags"
>> > ? and give those really quirky hardwares a chance to tell that reg_set
>> > ? and reg_dir are unreadable.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Applied, thanks.
>>
> Grant,
>
> Can you please pick up the RESEND version of the patch, which had
> bgpio_pdev_probe adapt bgpio_init parameter change too?

I did even though I replied to the original..  You can check my
gpio/next branch to be sure.

g.
