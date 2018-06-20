From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Jun 2018 22:02:17 -0500
Subject: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
In-Reply-To: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
Message-ID: <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/19/18 9:14 PM, Sinan Kaya wrote:
> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +		return;
> +
> +	dev->eetlp_prefix = 1;

How about:

	if (cap & PCI_EXP_DEVCAP2_E2ETLP)
		dev->eetlp_prefix = 1;

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
