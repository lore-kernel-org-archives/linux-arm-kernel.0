From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 16:47:22 -0800
Subject: [PATCH v2 1/5] devicetree: bindings: Document qcom board
 compatible format
In-Reply-To: <20151122204935.GA465@rob-hp-laptop>
References: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
 <1448062280-15406-2-git-send-email-sboyd@codeaurora.org>
 <20151122204935.GA465@rob-hp-laptop>
Message-ID: <20151124004722.GL19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22, Rob Herring wrote:
> On Fri, Nov 20, 2015 at 03:31:16PM -0800, Stephen Boyd wrote:
> > Some qcom based bootloaders identify the dtb blob based on a set
> > of device properties like SoC, platform, PMIC, and revisions of
> > those components. In downstream kernels, these values are added
> > to the different component dtsi files (i.e. pmic dtsi file, SoC
> > dtsi file, board dtsi file, etc.) via qcom specific DT
> > properties. The dtb files are parsed by a program called dtbTool
> > that picks out these properties and creates a table of contents
> > binary blob with the property information and some offsets into
> > the concatenation of all the dtbs (termed a QCDT image).
> > 
> > The suggestion is to do this via the board compatible string
> > instead, because these qcom specific properties are never used by
> > the kernel. Add a document describing the format of the
> > compatible string that encodes all this information that's
> > currently encoded in the qcom,{msm-id,board-id,pmic-id}
> > properties in downstream devicetrees. Future bootloaders may be
> > updated to look at the compatible field instead of looking for
> > the table of contents image. For non-updateable bootloaders, a
> > new dtbTool program will parse the compatible string and generate
> > a QCDT image from it.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Much more reasonable now. I do find the '/' in it a bit strange though.

I can remove the backslash if you like. Is a dash more preferred?

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

and if so can I keep the ack? I'll resend with that change and
add the ack.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
