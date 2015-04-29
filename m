From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 29 Apr 2015 16:30:51 +0200
Subject: [PATCH v2] ata: ahci_st: fixup layering violations / drvdata
 errors
In-Reply-To: <1429537265-22367-2-git-send-email-peter.griffin@linaro.org>
References: <1429537265-22367-1-git-send-email-peter.griffin@linaro.org>
 <1429537265-22367-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <5540EB1B.10505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 04/20/2015 03:41 PM, Peter Griffin wrote:
> Brian noticed while working on another SATA driver that uses libahci_platform,
> an error in this driver; it tries to the the driver data for its
> device, while libata also thinks it can set the driver data. See:
>
>    ahci_platform_init_host()
>    -> ata_host_alloc_pinfo()
>       -> ata_host_alloc()
>          -> dev_set_drvdata()
>
> So instead of sticking the IP-specific platform data into drvdata, let's
> use the plat_data variable that is reserved for this use.
>
> Addtionally plat_data isn't set until ahci_platform_init_host() has been
> called further down in probe(). So re-work the st_ahci_probe_resets and
> st_ahci_deassert_resets functions to take ahci_host_priv *hpriv as a
> parameter.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Suggested-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
