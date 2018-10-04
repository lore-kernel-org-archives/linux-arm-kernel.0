From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 16:12:40 +0200
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 3
In-Reply-To: <1538490605-26653-1-git-send-email-dinguyen@kernel.org>
References: <1538490605-26653-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAK8P3a2BjnCZQiR8qRE--=RHTaFw2kB-Jz=g0A0KvGpaaWY3DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 4:30 PM Dinh Nguyen <dinguyen@kernel.org> wrote:

> Dinh Nguyen (1):
>       arm64: dts: stratix10: add ethernet aliases

This one doesn't look quite right: you are adding the aliases in the .dtsi
files, which might be shared by multiple .dts files. There is no guarantee
that each board uses all three ethernet ports in the chip, even when all
boards we support in the kernel do.

Can you have a look at why those are not in the .dts file?

       Arnd
