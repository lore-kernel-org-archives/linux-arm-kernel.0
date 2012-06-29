From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 17:41:35 +0200
Subject: [PATCH RESEND] mfd: anatop: permit adata be NULL when access
 register
In-Reply-To: <1338774989-4416-1-git-send-email-richard.zhao@freescale.com>
References: <1338774989-4416-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120629154135.GL22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Jun 04, 2012 at 09:56:29AM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> It makes anatop register access easier. Anatop has many misc registers,
> which may not be a specific driver.
> 
> There's only one anatop device for a running system, so we use a global
> variable to store struct anatop.
Even though I understand it's quite unlikely that you'll never get 2 anatop
blocks on the same system, the below patch is not really nice.
Please make your driver support N > 1 instances of your hardware, even though
it's only for the sake of code cleanness.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
