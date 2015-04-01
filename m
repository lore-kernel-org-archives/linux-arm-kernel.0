From: tj@kernel.org (Tejun Heo)
Date: Wed, 1 Apr 2015 12:07:44 -0400
Subject: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
In-Reply-To: <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150401160744.GR9974@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 08:35:09AM +0100, Peter Griffin wrote:
> Currently the ahci_st driver will hang the system on probe, as the
> st_configure_oob function does some register writes before the IP
> is clocked. This patch moves the function call to after
> ahci_platform_enable_resources (which enables the IP clock), and
> resolves the hang.
> 
> Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
> function, so we also rectify that ensuring it is also called after
> the IP clock has been enabled.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Applied 1, 3 to libata/for-4.1.

Thanks.

-- 
tejun
