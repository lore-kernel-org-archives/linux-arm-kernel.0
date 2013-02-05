From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 13:39:32 -0800
Subject: [PATCH, RFC] default machine descriptor for multiplatform
In-Reply-To: <1638002.UJ7zfj1Wn5@wuerfel>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <20130131161823.GT2637@n2100.arm.linux.org.uk>
 <1731670.s76EGcEZ7m@wuerfel> <1638002.UJ7zfj1Wn5@wuerfel>
Message-ID: <CAOesGMiyKCdevdgnRu6gwzx214OEZvq18jCijTer5pnqwv3yww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 9:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is what I think it would look like to do a default platform
> with an empty machine descriptor on ARM. It makes the few required
> entries in the descriptor optional by using the new irqchip_init()
> and clocksource_of_init() functions as defaults, and adds
> a fallback for the DT case to customize_machine to probe all
> the default devices.
>
> For the case that CONFIG_MULTIPLATFORM is enabled, it then
> adds a machine descriptor that never matches any machine but
> is used as a fallback if nothing else matches.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice!

Acked-by: Olof Johansson <olof@lixom.net>

(Besides what Stephen already pointed out)

-Olof
