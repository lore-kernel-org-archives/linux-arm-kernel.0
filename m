From: rvolkov@v1ros.org (Roman Volkov)
Date: Sun, 1 Mar 2015 22:49:59 +0300
Subject: [PATCH v3 1/2] dts: vt8500: Add SDHC node to DTS file for WM8650
In-Reply-To: <54F35371.7020608@cogentembedded.com>
References: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>
 <1425226007-2757-1-git-send-email-rvolkov@v1ros.org>
 <1425226007-2757-2-git-send-email-rvolkov@v1ros.org>
 <54F35371.7020608@cogentembedded.com>
Message-ID: <20150301224959.4a106bfd@v1ron-s7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Sun, 01 Mar 2015 20:59:13 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> ?????:

> On 3/1/2015 7:06 PM, Roman Volkov wrote:
> 
> > Since WM8650 has the same 'WMT' SDHC controller as WM8505, and the
> > driver is already in the kernel, this node enables the controller
> > support for WM8650
> 
> > Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
> > Reviewed-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> 
> > diff --git a/arch/arm/boot/dts/wm8650.dtsi
> > b/arch/arm/boot/dts/wm8650.dtsi index b1c59a7..e12213d 100644
> > --- a/arch/arm/boot/dts/wm8650.dtsi
> > +++ b/arch/arm/boot/dts/wm8650.dtsi
> > @@ -187,6 +187,15 @@
> >   			interrupts = <43>;
> >   		};
> >
> > +		sdhc at d800a000 {
> 
>     According to the ePAPR standard, the device nodes should have
> generic names according to their functions, so this node should be
> named just "sd at d800a000".
> 
> WBR, Sergei
> 

Sergei,

Why not "sdmmc" or "sdhci" or "sdio" then? It would be great to name
nodes in same way, but there is no exact requirement in ePAPR v1.1
regarding SD/MMC controllers. Also, in Linux I don't see that someone
strictly follows this requirement. This renaming will affect driver,
since .compatible strings likely also need changing.

Roman
