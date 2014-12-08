From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Dec 2014 14:43:28 +0000
Subject: [STLinux Kernel] [PATCH v2 RESEND 10/11] mtd: st_spi_fsm:
 Provide mask to obtain correct boot device pins
In-Reply-To: <1417688512-7644-11-git-send-email-lee.jones@linaro.org>
References: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
 <1417688512-7644-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20141208144328.GA1104@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 04 Dec 2014, Lee Jones wrote:

> From: Christophe Kerello <christophe.kerello@st.com>
> 
> This patch adds a mask to be able to get the right boot device selection.

Have you seen this series I posted https://lkml.org/lkml/2014/11/19/71?

It is trying to consolodate the way the various STI drivers are handling syscfg
registers in the upstream kernel. Now this series came about mainly due to the mixing of address
spaces in the reg property, but the overall aim was to get all STI drivers handling
syscfg registers in a uniform way.

Sadly it seems this driver uses another approach for syscfg handling with extra
DT properties encoding the offset and mask.

IMHO I don't think it makes sense to add more DT properties for doing this. We should consider
migrating this over to using the interface provided in the series above, and for the mask I
would suggest implementing it in a similar way to the code in drivers/phy/phy-stih41x-usb.c 
which solves much the same problem by statically encoding the information in the driver
and making a decision based on the compatible flag.

regards,

Peter.
