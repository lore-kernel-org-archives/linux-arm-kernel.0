From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 28 May 2018 12:08:02 +0200
Subject: [PATCH v4 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
In-Reply-To: <20180525171941.26766-7-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-7-radu.pirea@microchip.com>
Message-ID: <e1445467-2df0-4593-852d-939e6795f318@sorico.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/2018 19:19, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 40 +++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
the stdout-path property of the chosen node is still broken in this verion.
if :
stdout-path = "serial0:115200n8";
is set in the DTS, the console output should go on serial0 (aka dbgu)
cf Documentation/devicetree/bindings/chosen.txt

With this patch applied, this is not the case anymore.
Adding console=ttyS0,115200 in the chosen node is not the solution here.


regards,
Richard.
