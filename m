From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Jan 2012 09:04:31 +0530
Subject: [PATCH] gpio: pl061: remove combined interrupt
In-Reply-To: <1325705506-24230-1-git-send-email-robherring2@gmail.com>
References: <1325705506-24230-1-git-send-email-robherring2@gmail.com>
Message-ID: <4F051A47.3020401@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/5/2012 1:01 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Drivers should not have a dependency on NR_IRQS. Doing so may break with
> SPARSE_IRQ enabled. As there are no in kernel users of the pl061 which
> have multiple instances with their interrupts combined to a single parent
> interrupt, remove this functionality. If this capability is needed later,
> it could be supported more cleanly by just using a devicetree property.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/gpio/gpio-pl061.c |   44 ++++++++------------------------------------
>  1 files changed, 8 insertions(+), 36 deletions(-)

Looks fine.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
