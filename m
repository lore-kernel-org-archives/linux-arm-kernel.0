From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 9 Feb 2016 20:50:25 +0530
Subject: [PATCH] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
In-Reply-To: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
References: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
Message-ID: <56BA03B9.2010801@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 09 February 2016 07:57 PM, Lee Jones wrote:
> +
> +#define MFD_CELL_NAME(_name)						\
> +	{								\
> +		MFD_CELL_ALL(_name, NULL, NULL, 0, NULL, NULL)		\
> +	}
> +
>   struct irq_domain;

It is failed in compilation as we can not use ARRAY_SIZE(NULL)

static struct mfd_cell max77620_children[] = {
         MFD_CELL_NAME("max77620-pinctrl"),
};

  CC      drivers/mfd/max77620.o
drivers/mfd/max77620.c:57:2: warning: braces around scalar initializer
   MFD_CELL_NAME("max77620-pinctrl"),

include/linux/compiler-gcc.h:64:63: warning: taking address of 
expression of type 'void'
  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                                                ^
include/linux/bug.h:33:55: note: in definition of macro 'BUILD_BUG_ON_ZERO'
  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                        ^
include/linux/compiler-gcc.h:64:46: note: in expansion of macro 
'__same_type'
  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
