From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 7 Jul 2010 14:32:43 +0200
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA42DA39B5220@GEORGE.Emea.Arm.com>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
	<F01D8B85CFF58440B2A13965FBA90CA42DA39B5220@GEORGE.Emea.Arm.com>
Message-ID: <AANLkTimdl0q5S3Vhog6WN1L0oy82yVkYkmAV_SCK5N9S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/7 Colin Tuckley <Colin.Tuckley@arm.com>:

>> The 4bit mode is the only one that seems to work. I tried putting
>> the display into 8bit mode and failed miserably.
>
> I've had a check with the hardware guys. Our self-test software uses the
> 4-bit mode, the 8-bit mode is untested.

OK I can make another round. I modeled the 4bit mode after
the ROM selftest actually.

The phenomenon is like commands go through in 8bit but not
characters, so whatever you write into CHAR_DAT only the 4 higher
bits go through, often with the effect of letters like "@@@@@" in
the display (if you write something with big letters).

>> The IRQ is stated in the reference manual as "don't use" because it
>> is "reserved for future use" but I implemented it anyway.
>
> The answer seems to be that "future use" means "for an OS".

Aha OK, then it's all mine! :-)

Yours,
Linus Walleij
