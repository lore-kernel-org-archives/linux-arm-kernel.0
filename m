From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2011 14:15:38 +0200
Subject: [PATCH] pinmux: add a driver for the CSR SiRFprimaII pinmux
In-Reply-To: <CAGsJ_4xXMx7_G2ADJF-s4Xws4k4XqBnE3eysokd66ogdb=jbOA@mail.gmail.com>
References: <1314329782-17238-1-git-send-email-Baohua.Song@csr.com>
	<CACRpkdYmmY8ycBUL70ERawumSMdZEORYsmMBxBxZxchcfMS7EA@mail.gmail.com>
	<CAGsJ_4xXMx7_G2ADJF-s4Xws4k4XqBnE3eysokd66ogdb=jbOA@mail.gmail.com>
Message-ID: <CACRpkdb=V2MSyQy+9KXYCRE2O0sttF9XNTp4Jiug4Z-Cqs6nWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 1:58 PM, Barry Song <21cnbao@gmail.com> wrote:
>> > +static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
>> > + ? ? ? {
>> > + ? ? ? ? ? ? ? .group = 3,
>> > + ? ? ? ? ? ? ? .mask = 0x7FFFF,
>>
>> These things look a bit magic...
>
> register seems to be magic by itself. this is register set mask of
> group 3 for LCD. group in the structure is also an offset of register
> layout.

No big deal anyway.

What some people like myself do is make #defines for most
things:

#define SIRFSOC_LCD_GROUP_OFFSET 3
#define SIRFSOC_LCD_GROUP_MASK 0x7FFFF
#define SIRFSOC_LCD_ENABLE BIT(5)

sometimes I even define shifts for masks etc.

But a comment inline explaining the magic bits is just as
fine with me.

Yours,
Linus Walleij
