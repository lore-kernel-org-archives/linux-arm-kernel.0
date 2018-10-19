From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:09:17 +0300
Subject: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86
 tree
In-Reply-To: <20181010172300.317643-6-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-6-lkundrak@v3.sk>
Message-ID: <CAHp75VdNJwWbKfbsMQ2ZVmC=H3yPaLgxnE4Kstff9CYeopZJ7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There are ARM OLPC machines that use mostly the same drivers, including
> EC infrastructure, DCON and Battery.
>
> While at that, fix Kconfig to allow building this as a module.


> -       depends on MOUSE_PS2 && OLPC
> +       depends on MOUSE_PS2 && X86 && OLPC


> -       depends on OLPC && FB
> +       depends on X86 && OLPC && FB

Looking to this I would rather introduce an idiom

depends on OLPC && X86

on the opposite you may do similar for ARM

depends on OLPC && ARM // or ARM64 or whatever it's called

thus, above would look like

depends on MOUSE_PS2
depends on OLPC && X86

and

depends on FB
depends on OLPC && X86

respectively.

-- 
With Best Regards,
Andy Shevchenko
