From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:30:06 +0100
Subject: [GIT PULL] tee dynamic shm for v4.16
In-Reply-To: <20171215132057.ang2xawtpzp5eb6o@jax>
References: <20171215132057.ang2xawtpzp5eb6o@jax>
Message-ID: <CAK8P3a09za3vGW5P5xDExurTtB=s8adcvz_m-czrE4cZcorGmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 2:21 PM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hello arm-soc maintainers,
>
> Please pull these tee driver changes. This implements support for dynamic
> shared memory support in OP-TEE. More specifically is enables mapping of
> user space memory in secure world to be used as shared memory.
>
> This has been reviewed and refined by the OP-TEE community at various
> places on Github during the last year. An earlier version of this pull
> request is used in the latest OP-TEE release (2.6.0). This has also been
> reviewed recently at the kernel mailing lists, with all comments from
> Mark Rutland <mark.rutland@arm.com> and Yury Norov
> <ynorov@caviumnetworks.com> addressed as far as I can tell.
>
> This isn't a bugfix so I'm aiming for the next merge window.

Given that Mark and Yury reviewed this, I'm assuming this is all
good and have now merged it. However I missed the entire discussion
about it, so I have one question about the implementation:

What happens when user space passes a buffer that is not
backed by regular memory but instead is something it has itself
mapped from a device with special page attributes or physical
properties? Could this be inconsistent when optee and user
space disagree on the caching attributes? Can you get into
trouble if you pass an area from a device that is read-only
in user space but writable from secure world?

      Arnd
