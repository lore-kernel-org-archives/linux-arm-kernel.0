From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Apr 2018 12:13:23 +0100
Subject: [PATCH] efi/libstub/arm64: handle randomized TEXT_OFFSET
In-Reply-To: <CAKv+Gu813jnf1RPU0HKMXapeK04XhJMveeLb9uppx7recyUW5w@mail.gmail.com>
References: <20180424110058.29344-1-mark.rutland@arm.com>
 <CAKv+Gu813jnf1RPU0HKMXapeK04XhJMveeLb9uppx7recyUW5w@mail.gmail.com>
Message-ID: <20180424111323.ifqq7hathc3n54ne@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 01:11:40PM +0200, Ard Biesheuvel wrote:
> Hi Mark,
> 
> On 24 April 2018 at 13:00, Mark Rutland <mark.rutland@arm.com> wrote:
> > When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
> > arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
> >
> > The EFI stub doesn't accuont for this, and only handles the case where
> 
> 'account'
> 
> If you agree, I will add something here to clarify that the newly
> chosen offset should retain the misalignment of TEXT_OFFSET relative
> to EFI_KIMG_ALIGN, because it took me a while to figure that out.

That makes sense to me. Sorry for the clumsy wording!

> 
> Other than that,
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> I will queue this as a fix

Great; thanks!

Mark.
