From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 5 Apr 2017 09:36:47 -0700
Subject: [PATCH v5 22/23] drivers/fsi: Add hub master support
In-Reply-To: <20170405020607.79939-23-cbostic@linux.vnet.ibm.com>
References: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
 <20170405020607.79939-23-cbostic@linux.vnet.ibm.com>
Message-ID: <8c841062-62e9-77c6-b0c9-e0da73cad3ac@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/17 19:06, Christopher Bostic wrote:
> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
> 
> Add an engine driver to expose a "hub" FSI master - which has a set of
> control registers in the engine address space, and uses a chunk of the
> slave address space for actual FSI communication.
> 
> Additional changes from Jeremy Kerr <jk@ozlabs.org>.
> 
> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/Kconfig          |   9 ++
>  drivers/fsi/Makefile         |   1 +
>  drivers/fsi/fsi-master-hub.c | 327 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 drivers/fsi/fsi-master-hub.c
> 
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 0fa265c..e1156b4 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -18,6 +18,15 @@ config FSI_MASTER_GPIO
>  	---help---
>  	This option enables a FSI master driver using GPIO lines.
>  
> +config FSI_MASTER_HUB
> +	tristate "FSI hub master"
> +	depends on FSI

redundant again.

> +	---help---
> +	This option enables a FSI hub master driver.  Hub is a type of FSI
> +	master that is connected to the upstream master via a slave.  Hubs
> +	allow chaining of FSI links to an arbitrary depth.  This allows for
> +	a high target device fanout.
> +
>  config FSI_SCOM
>  	tristate "SCOM FSI client device driver"
>  	depends on FSI


-- 
~Randy
