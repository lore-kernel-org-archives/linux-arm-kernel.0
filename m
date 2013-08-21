From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 21 Aug 2013 14:48:50 -0500
Subject: [PATCHv4 2/3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <520EA97D.7050404@wwwdotorg.org>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
 <1376498884-9199-2-git-send-email-dinguyen@altera.com>
 <520EA97D.7050404@wwwdotorg.org>
Message-ID: <1377114530.1554.13.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-16 at 16:36 -0600, Stephen Warren wrote:
> On 08/14/2013 10:48 AM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> > +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> > +		this where the register that controls the CIU clock phases
> > +		reside.
> 
> On the surface, this binding series seems OK, but I do have a question:
> how is the sysmgr phandle used?
> 
> I assume there's some register in this syscon device that resets or
> enables or otherwise controls this MSHC module. How does the code know
> which register it is? The phandle in the altr,sysmgr property would
> usually be followed by a/some cell(s) that encode this information, so
> that the MSHC driver doesn't have to know anything about the layout of
> the syscon registers, and so the sysconf driver doesn't have to know
> anything about the identity of the MSHC client device.

There is a #define SYSMGR_SDMMCGRP_CTRL_OFFSET that is in
dw_mmc-socfpga.c. This defines the offset from the base address that the
sysmgr phandle will give me.

> 
> That way, the MSHC driver will work fine if a HW designer has dropped
> the MSHC IP block into a completely different SoC with a different
> syscon register layout.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
