From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 6 Jun 2013 20:06:04 -0300
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <20130606200519.GA1644@kroah.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <20130606200519.GA1644@kroah.com>
Message-ID: <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingchang,

On Thu, Jun 6, 2013 at 5:05 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Jun 04, 2013 at 09:27:50AM +0800, Jingchang Lu wrote:
>> Add Freescale lpuart driver support. The lpuart device
>> can be found on Vybrid VF610 and Layerscape LS-1 SoCs.
>>
>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>
> This breaks the build on x86 systems with:
>   CC [M]  drivers/tty/serial/fsl_lpuart.o
> drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_probe?:
> drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of function ?of_alias_get_id? [-Werror=implicit-function-declaration]
>
> so I can't take this :(

On imx serial driver this build error is avoided by protecting the
serial_imx_probe_dt() with "#ifdef CONFIG_OF" and you could so the
same on the fsl_lpaurt driver to avoid the build issue that Greg
reported.

Regards,

Fabio Estevam
