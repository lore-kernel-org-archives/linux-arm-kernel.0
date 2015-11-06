From: agross@codeaurora.org (Andy Gross)
Date: Fri, 6 Nov 2015 14:15:04 -0600
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151106201504.GA18276@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 02:25:10PM -0700, Stephen Boyd wrote:
> Some qcom based bootloaders identify the dtb blob based on a set
> of device properties like SoC, platform, PMIC, and revisions of
> those components. In downstream kernels, these values are added
> to the different component dtsi files (i.e. pmic dtsi file, SoC
> dtsi file, board dtsi file, etc.) via qcom specific DT
> properties. The dtb files are parsed by a program called dtbTool
> that picks out these properties and creates a table of contents
> binary blob with the property information and some offsets into
> the concatenation of all the dtbs (termed a QCDT image).
> 
> The suggestion is to do this via the board compatible string
> instead, because these qcom specific properties are never used by
> the kernel. Add a document describing the format of the
> compatible string that encodes all this information that's
> currently encoded in the qcom,{msm-id,board-id,pmic-id}
> properties in downstream devicetrees. Future bootloaders may be
> updated to look at the compatible field instead of looking for
> the table of contents image. For non-updateable bootloaders, a
> new dtbTool program will parse the compatible string and generate
> a QCDT image from it.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Looks workable.

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
