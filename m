From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 31 Oct 2017 11:17:52 +0100
Subject: CONFIG_ARCH_SUPPORTS_INT128 for AArch64
Message-ID: <CAHmME9q3=k2fJMi4Zy6d=ewj-P=sRhB8c_MjSJAMbKkopThi1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

Older versions of gcc are horrible for int128_t on aarch64, emitting a
__multi3 call, which is slow and defeats the purpose. However, more
recent versions of gcc (since 5, IIRC), do the right thing and produce
the proper inlined instructions.

Do we have the infrastructure available to test for this, and
conditionally set CONFIG_ARCH_SUPPORTS_INT128 if we do?

Thanks,
Jason
