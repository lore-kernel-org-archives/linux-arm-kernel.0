From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 17 Jan 2011 16:48:02 +0100
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
	body copying
In-Reply-To: <AANLkTin6gfN6hpExQ0iof14Hy7_MmaOdgpgS2OgyZOLd@mail.gmail.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
	<AANLkTin6gfN6hpExQ0iof14Hy7_MmaOdgpgS2OgyZOLd@mail.gmail.com>
Message-ID: <AANLkTik4Q9f4t_CrNxcov+iSnpNkZ-KeGZJPcKuQvj2G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Mon, Jan 17, 2011 at 4:35 PM, Dave Martin <dave.martin@linaro.org> wrote:
> Hi,
>
> On Mon, Jan 17, 2011 at 2:02 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
> [...]
>
>> Note that aligning the source and destination pointers to a multiple
>> of 8 bytes has an impact on the behavio(u)r and so must be carefully
>> thought and tested on OMAP1/2/3 platforms.
>
> Do you have any specific concerns regarding this?
>
> Currently, the only issue I can think of is that the need to allocate
> aligned memory from the SRAM will increase the total amount allocated,
> which could be a problem if we end up overflowing the available SRAM.
Agree. It does not look like there are SRAM overflows today. Note that
in that case you will get warned soon enough by the 'Not enough space
in SRAM' message.
One could think about some nasty side-effects bugs like badly written
PIC code, hardcoded addresses... that appear to work with the current
version. In short this needs to be thoroughly tested on OMAP1/2/3
platforms.

> This does not appear to happen in the case I've tested -- I currently
> round up the amount allocated in omap_sram_push to be a multiple of 8
> bytes. ?This, combined with a couple of ".align 3" directives, is
> enough to get me a booting system on omap3... but I haven't tested
> exhaustively.
That is OK. I have a patch ready for OMAP1/2/3, tested on OMAP3 only.

> Cheers
> ---Dave
>

Thanks,
Jean
