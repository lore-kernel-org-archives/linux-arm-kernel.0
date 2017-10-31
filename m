From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Oct 2017 10:43:32 +0000
Subject: CONFIG_ARCH_SUPPORTS_INT128 for AArch64
In-Reply-To: <CAHmME9q3=k2fJMi4Zy6d=ewj-P=sRhB8c_MjSJAMbKkopThi1w@mail.gmail.com>
References: <CAHmME9q3=k2fJMi4Zy6d=ewj-P=sRhB8c_MjSJAMbKkopThi1w@mail.gmail.com>
Message-ID: <20171031104332.gqpd6icvrxt2uj4c@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 11:17:52AM +0100, Jason A. Donenfeld wrote:
> Hi folks,
> 
> Older versions of gcc are horrible for int128_t on aarch64, emitting a
> __multi3 call, which is slow and defeats the purpose. However, more
> recent versions of gcc (since 5, IIRC), do the right thing and produce
> the proper inlined instructions.
> 
> Do we have the infrastructure available to test for this, and
> conditionally set CONFIG_ARCH_SUPPORTS_INT128 if we do?

Judging by Documentation/kbuild/makefiles.txt, we could do something
like the below in the arm64 Makefile:

cflags-y += $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)

Note that I havent tested this at all.

Thanks,
