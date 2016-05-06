From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 6 May 2016 10:31:49 -0400
Subject: [PATCH 0/3] Support MPS2 UART controller
In-Reply-To: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
References: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAP=VYLopd8erCP9J9cTyZ+YubafKjWi3bHQp-swmyfyn2eZ_Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 4:47 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> Hi,
>
> These patches allow to use UART controller found on MPS2 platform.

Did you intend this driver to support being modular?  It has a bool Kconfig
(not tristate) which makes the module_exit dead code.

If it will always be builtin (with console as primary use case) then you can
see commit 89ebc27427695bfc1e769f1dd99bd243d332ac7a as a possible
update suggestion.

P.
--

>
> Following [1], please, consider to merge them into tty/serial tree.
>
> [1] https://lkml.org/lkml/2016/4/23/190
>
> Thanks!
>
> Vladimir Murzin (3):
>   dt-bindings: document the MPS2 UART bindings
>   serial: mps2-uart: add MPS2 UART driver
>   serial: mps2-uart: add support for early console
>
>  .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 +
>  drivers/tty/serial/Kconfig                         |   13 +
>  drivers/tty/serial/Makefile                        |    1 +
>  drivers/tty/serial/mps2-uart.c                     |  625 ++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |    3 +
>  5 files changed, 661 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
>  create mode 100644 drivers/tty/serial/mps2-uart.c
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
