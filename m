From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 25 Nov 2018 18:29:34 -0200
Subject: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
In-Reply-To: <20181125201729.19836-1-otavio@ossystems.com.br>
References: <20181125201729.19836-1-otavio@ossystems.com.br>
Message-ID: <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Otavio,

On Sun, Nov 25, 2018 at 6:18 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> The setting is removed when running a `savedefconfig` using the
> current setting set. It is being applied in preparation to some

"setting set" is a bit confusing.

> patches making changes to this defconfig.

It would be good to mention that CONFIG_ARM_UNWIND is still selected
automatically.

Otherwise it may give the impression that such functionality is being removed.

You could reword the commit log to something like this:

CONFIG_ARM_UNWIND is removed when running  'savedefconfig', but it is
still selected by the Kconfig logic.
This is done in preparation to making further changes to this defconfig cleaner.

With the reworded commit log:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
