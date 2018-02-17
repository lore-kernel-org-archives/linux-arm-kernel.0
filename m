From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Feb 2018 20:51:14 +0100
Subject: syscon regmap for disabled node?
In-Reply-To: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
References: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
Message-ID: <CAK8P3a25wQiCreFB3qBuyE86GvwmjpZmqyTszF-ZBJRDPwHotQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 2:40 AM, Suman Anna <s-anna@ti.com> wrote:
> Hi Pankaj, Arnd, Lee,
>
> I am testing some code to use a syscon/regmap interface and I find that
> the syscon/regmap is initialized even on a disabled device node using a
> "syscon" compatible property when I have expected it to fail. Prior to
> commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
> platform devices"), the driver would have never probed, and the
> of_syscon_register() only checks for the compatible, but not if the
> device node is available. Is this intentional or a bug?

My guess would be that nothing relies on the current behavior and that
it could be changed if it causes problems, but it's hard to tell for the general
case.

Can you describe why you have a disabled syscon node? Most uses of the
status property are for on-chip devices that we disable because nothing is
connected to them, but that seems unlikely for a syscon.

        Arnd
