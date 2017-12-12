From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Dec 2017 14:51:04 -0600
Subject: [PATCH v4 09/12] clk: qcom: Add Krait clock controller driver
In-Reply-To: <1512726150-7204-10-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-10-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171212205104.vnnjr3w56w4mrfh6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 03:12:27PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> The Krait CPU clocks are made up of a primary mux and secondary
> mux for each CPU and the L2, controlled via cp15 accessors. For
> Kraits within KPSSv1 each secondary mux accepts a different aux
> source, but on KPSSv2 each secondary mux accepts the same aux
> source.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++

Please make bindings a separate patch.

>  drivers/clk/qcom/Kconfig                           |   8 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/krait-cc.c                        | 350 +++++++++++++++++++++
>  4 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 drivers/clk/qcom/krait-cc.c
