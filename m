From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Jul 2017 09:39:18 +0530
Subject: [PATCH 1/2] dmaengine: qcom_hidma: correct overriding message
In-Reply-To: <1500215438-30672-1-git-send-email-okaya@codeaurora.org>
References: <1500215438-30672-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170719040917.GD3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 16, 2017 at 10:30:37AM -0400, Sinan Kaya wrote:
> A false overriding information is being presented during boot
> under this scenario.
> 
> 1. First object checks for kernel command line value against zero.
> 2. It doesn't find it, it sets the command line variable to the
> value coming from ACPI/DT.
> 3. Second object is being probed.
> 4. Second object sees that the value of kernel command line
> override is non-zero, it prints an overriding message even though
> value matches ACPI/DT value.
> 
> hidma-mgmt QCOM8060:03: overriding max-write-burst-bytes: 1024
> 
> Add an additional check to verify that kernel command line value
> is different from the ACPI/DT value.

Applied both, thanks

-- 
~Vinod
