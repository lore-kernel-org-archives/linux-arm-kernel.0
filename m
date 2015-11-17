From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Nov 2015 06:33:46 +0100
Subject: [PATCH v2 11/12] ARM: wire up UEFI init and runtime support
In-Reply-To: <20151116194812.GJ8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-12-git-send-email-ard.biesheuvel@linaro.org>
 <20151116190156.GH8644@n2100.arm.linux.org.uk>
 <CAKv+Gu8w+2GA5tV4roYtEsza+mkCZKYX_=tT2t=+eh-ZO1Y2fA@mail.gmail.com>
 <20151116194812.GJ8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8H5oqrke-TpMj9i00=OJpi82NKySF40yVQoOhXbaQvXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 20:48, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 08:04:00PM +0100, Ard Biesheuvel wrote:
>> OK. So you mean set TTBR to the zero page, perform the TLB flush and
>> only then switch to the new page tables?
>
> Not quite.
>
> If you have global mappings below TASK_SIZE, you would need this
> sequence when switching either to or from the UEFI page tables:
>
> - switch to another set of page tables which only map kernel space
>   with nothing at all in userspace.
> - flush the TLB.
> - switch to your target page tables.
>

Doh. I am so used to always having two TTBR's available, but indeed,
we shouldn't pull the rug from under our feet.

> As I say in response to one of your other patches, it's probably
> much easier to avoid any global mappings below TASK_SIZE.

Let me look into that.

Thanks,
Ard.
