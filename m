From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Apr 2014 21:54:26 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <53503E5D.8000301@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <alpine.LFD.2.11.1404171543350.980@knanqh.ubzr>
 <53503E5D.8000301@codeaurora.org>
Message-ID: <CAFEAcA_HZoPDoF-mJaB0tALJGr5U1xQ7Y=34nJvn3jU4Y0sT7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2014 21:49, Christopher Covington <cov@codeaurora.org> wrote:
> In any case, when performing boot debugging I'm not as interested in
> traditional self-hosted bootloaders as I am external loaders, like those built
> into software models (QEMU, Fast Models, etc.) or available to JTAG scripts
> (OpenOCD, Trace32, etc.). These seem to generally have ELF support.

FWIW ARM QEMU won't boot an ELF kernel -- the assumption is
that an ELF file is not a kernel and should just be put into RAM
and run, whereas a non-ELF file is a kernel and gets the special
setup/handling of secondary CPUs/etc that the Booting document
requires.

thanks
-- PMM
