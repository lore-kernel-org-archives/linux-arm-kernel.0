From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jan 2014 15:55:45 +0000
Subject: [PATCH RESEND v4 01/37] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <52E12434.7030000@st.com>
References: <1390473085-24626-1-git-send-email-lee.jones@linaro.org>
 <1390473085-24626-2-git-send-email-lee.jones@linaro.org>
 <52E12434.7030000@st.com>
Message-ID: <20140123155545.GH8586@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >+	fsm->region = devm_request_mem_region(&pdev->dev, res->start,
> >+					      resource_size(res), pdev->name);
> >+	if (!fsm->region) {
> >+		dev_err(&pdev->dev,
> >+			"Failed to reserve memory region [0x%08x-0x%08x]\n",
> >+			res->start, res->end);
> >+		return -EBUSY;
> >+	}
> >+
> >+	fsm->base = devm_ioremap_nocache(&pdev->dev,
> >+					 res->start, resource_size(res));
> >+	if (!fsm->base) {
> >+		dev_err(&pdev->dev, "Failed to ioremap [0x%08x]\n", res->start);
> >+		return -EINVAL;
> >+	}
> >+
> you can replace  "devm_request_mem_region" & "devm_ioremap_nocache"
> by "devm_ioremap_resource"

Yes, that looks entirely reasonable, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
