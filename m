From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jun 2016 15:45:44 +0100
Subject: [PATCH 2/3] Documentation: add DT bindings for ARM SCPI power
 domains
In-Reply-To: <5756CE8D.6040704@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-3-git-send-email-sudeep.holla@arm.com>
 <20160607132223.GG2633@leverpostej> <5756CE8D.6040704@arm.com>
Message-ID: <20160607144544.GC26981@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 02:39:25PM +0100, Sudeep Holla wrote:
> 
> 
> On 07/06/16 14:22, Mark Rutland wrote:
> >On Mon, Jun 06, 2016 at 04:53:58PM +0100, Sudeep Holla wrote:
> >>The System Control Processor (SCP) provides peripheral devices with
> >>power domains that can be enabled and disabled viathe System Control
> >>and Power Interface (SCPI) Message Protocol. Add bindings to allow
> >>probing of these device power domians.
> >>
> >>Cc: Rob Herring <robh+dt@kernel.org>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: linux-arm-kernel at lists.infradead.org
> >>Cc: devicetree at vger.kernel.org
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>---
> >>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 34 ++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> >>index 313dabdc14f9..7141670d649b 100644
> >>--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> >>+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> >>@@ -87,10 +87,33 @@ SCPI provides an API to access the various sensors on the SoC.
> >>  			 implementation for the IDs to use. For Juno
> >>  			 R0 and Juno R1 refer to [3].
> >>
> >>+Power domain bindings for the power domains based on SCPI Message Protocol
> >>+------------------------------------------------------------
> >>+
> >>+This binding uses the generic power domain binding[4].
> >>+
> >>+PM domain providers
> >>+===================
> >>+
> >>+Required properties:
> >>+ - #power-domain-cells : Should be 1. Contains the device or the power
> >>+			 domain ID value used by SCPI commands.
> >>+ - num-domains: Total number of power domains provided by SCPI. This is
> >>+		needed as the SCPI message protocol lacks a mechanism to
> >>+		query this information runtime.
> >                                       ^
> >I guess there should be an 'at' here.
> >
> 
> Will fix.
> 
> >Are domain IDs zero-based and definitely non-sparse?
> >
> 
> Yes

Ok. So FWIW, with the fix above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
