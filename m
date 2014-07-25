From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 25 Jul 2014 07:43:44 -0700
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <53D21458.3060403@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-7-git-send-email-afaerber@suse.de>
 <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
 <53D20F2A.5020209@monstr.eu> <53D21458.3060403@suse.de>
Message-ID: <9d1e0d28-1fa2-4ef4-9d6f-b64829223f74@BN1AFFO11FD021.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 10:24AM +0200, Andreas F?rber wrote:
> Am 25.07.2014 10:02, schrieb Michal Simek:
> > On 07/25/2014 01:28 AM, S?ren Brinkmann wrote:
> >> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> >>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >>> ---
> >>>  v2: New
> >>>  
> >>>  arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
> >>>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
> >>>  2 files changed, 21 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> >>> index eed3df0..1a70277 100644
> >>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> >>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> >>> @@ -223,6 +223,23 @@
> >>>  			};
> >>>  		};
> >>>  
> >>> +		dmac_s: dmac at f8003000 {
> >>> +			compatible = "arm,pl330", "arm,primecell";
> >>> +			reg = <0xf8003000 0x1000>;
> >>> +			status = "disabled";
> >> I think for this IP we can omit the 'status' property since it is always
> >> enabled. I don't see a reason to override it in each board DT.
> > 
> > Done this change myself
> 
> Fine with me, but allow me to point out that the TRM documents the DMAC
> being mapped as DMAC S at the above address, and as DMAC NS at F800_4000
> (secure vs. non-secure, ch. 4.6, p. 116). Not sure how this would be
> handled driver-wise if not through alternative dt nodes?

The upstream Linux runs in secure state on Zynq, hence I think this is fine. If
somebody wants to run Linux on Zynq non-secure they have to do some work
anyhow. This way the standard configuration can use the DMA engine.

	S?ren
