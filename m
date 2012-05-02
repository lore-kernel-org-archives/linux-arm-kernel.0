From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 May 2012 01:33:20 -0600 (MDT)
Subject: [PATCH 1/1] [RESEND] ARM: OMAP3+: dpll: Configure autoidle mode
 only if it's supported
In-Reply-To: <1335774722-6728-1-git-send-email-vaibhav.bedia@ti.com>
References: <1335774722-6728-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <alpine.DEB.2.00.1205020133080.19695@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Apr 2012, Vaibhav Bedia wrote:

> The current DPLL code enables and disables autoidle features
> without checking whether the autoidle register is available.
> Fix this by putting a check for the existence of the autoidle
> register in the DPLL data.
> 
> With such a check in place, for DPLLs which do not support this
> feature, simply skipping the autoidle_reg entry in the DPLL data
> is sufficient.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
> This change is needed for AM33xx, which does not support
> autoidle mode for the DPLLs.

Thanks, queued for 3.5.


- Paul
