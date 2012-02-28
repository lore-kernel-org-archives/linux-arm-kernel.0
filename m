From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 09:50:15 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F4BFB79.30801@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F4BFB79.30801@freescale.com>
Message-ID: <20120228015012.GA13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 03:54:01PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > The fsl_ssi probe function detects the client machine name using model
> > property of the device tree.  But it will not work for the ARM client
> > machines which are to be added.  The model property is given as a
> > descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> > Instead, the compatible property gives the machine name.
> 
> If you apply this change to the P1022DS as well, then you can eliminate
> the need to check for "P1022" and "P1022DS", since the compatible string
> in the P1022DS DTS has always said, "fsl,P1022DS".
> 
Since I was asked by Mark to use new binding for new machine driver,
I would drop this patch and keep PowerPC machine drivers working with
/model property.

-- 
Regards,
Shawn
