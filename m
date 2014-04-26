From: yinghai@kernel.org (Yinghai Lu)
Date: Fri, 25 Apr 2014 23:19:59 -0700
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <1397859600-11507-4-git-send-email-robherring2@gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
Message-ID: <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 3:19 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <robh@kernel.org>
>
> With the generic earlycon infrastructure in place, convert the 8250
> early console to use it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/serial/8250/8250_early.c | 138 ++++-------------------------------
>  drivers/tty/serial/8250/Kconfig      |   1 +
>  2 files changed, 16 insertions(+), 123 deletions(-)

Hi Greg, Rob

This one in tty-next breaks booting: "console=uart8250,io,0x3f8,115200".
No early console and regular console anymore.

It should produce "early con and regular con".

Thanks

Yinghai
