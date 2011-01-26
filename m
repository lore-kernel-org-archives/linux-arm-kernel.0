From: miltonm@bga.com (Milton Miller)
Date: Wed, 26 Jan 2011 12:27:50 -0600
Subject: [RFC,1/5] arm/dt: Add dt machine definition
In-Reply-To: <20110126044406.16410.22096.stgit@localhost6.localdomain6>
References: <20110126044406.16410.22096.stgit@localhost6.localdomain6>
Message-ID: <lkml-patchwork-507601-use-section@mdm.bga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jan 2011 about 04:44:06 -0000, Grant Likely wrote:
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

needs a description ...
> 
> ---
> arch/arm/include/asm/mach/arch.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> 
>  
> +#define MACH_TYPE_DT	0xffffffff
> +
> +#define DT_MACHINE_START(_name, _namestr)		\
> +static const struct machine_desc __mach_desc_##_name	\
> + __used							\
> + __attribute__((__section__(".arch.info.init"))) = {	\

linux/compiler.h defines __section for this

> +	.nr		= MACH_TYPE_DT,			\
> +	.name		= _namestr,
> +
>  #endif

milton
