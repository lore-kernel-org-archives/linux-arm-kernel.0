From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 17:43:00 +0100
Subject: [PATCH 1/3] ARM: clps711x: mark clps711x_compat as const
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
Message-ID: <CAK8P3a36AuFon2vC+6rz+_-kBaeceBvwMYCNX8=+SrdT3-ZqDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 5:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The array of string pointers is put in __initconst, and the strings themselves
> are marke 'const' but the the pointers are not, which caused a warning when
> built with LTO:
>
> arch/arm/mach-clps711x/board-dt.c:72:20: error: 'clps711x_compat' causes a section type conflict with 'feroceon_ids'
>  static const char *clps711x_compat[] __initconst = {
>
> This marks the array itself const as well, which was certainly the
> intention originally.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to the fixes branch now.

      Arnd
