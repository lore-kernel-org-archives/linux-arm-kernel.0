From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2017 23:06:31 +0100
Subject: [PATCH] arm64: fix warning about swapper_pg_dir overflow
In-Reply-To: <CAKv+Gu_FMk26Vbrb3mp5cSkSvmELP2iantX4kTyg+U8HO0J9ug@mail.gmail.com>
References: <20170214212718.2792194-1-arnd@arndb.de>
 <CAKv+Gu_FMk26Vbrb3mp5cSkSvmELP2iantX4kTyg+U8HO0J9ug@mail.gmail.com>
Message-ID: <CAK8P3a171gaVo0hOeqWQQGOnRaTTqc83u9r9dwMz0ZGE1O=R9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:33 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 14 February 2017 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:

> We should see the same issue with 64k/3 levels, since its PGD_SIZE is
> also much smaller than its PAGE_SIZE. This is a much more common
> configuration, so I am surprised you found it on 16k/4 levels first.

I hadn't been doing regular build tests on arm64 and just started up some
randconfig builds, this was the first bug I ran into ;-)

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks,

   Arnd
