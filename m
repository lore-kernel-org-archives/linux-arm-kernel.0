From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Jul 2013 10:01:53 +0800
Subject: [PATCH v2] ARM: mx6: Fix the number of reported cores
In-Reply-To: <1372870510-14624-1-git-send-email-festevam@gmail.com>
References: <1372870510-14624-1-git-send-email-festevam@gmail.com>
Message-ID: <20130704020151.GB14617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 01:55:10PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On a mx6 quad-core processor:
> 
> $ cat /proc/cpuinfo                                             
> processor       : 0                                                             
> model name      : ARMv7 Processor rev 10 (v7l)                                  
> BogoMIPS        : 1581.05                                                       
> Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls               
> CPU implementer : 0x41                                                          
> CPU architecture: 7                                                             
> CPU variant     : 0x2                                                           
> CPU part        : 0xc09                                                         
> CPU revision    : 10                                                            
> 
> ,which incorrectly shows this is a single core device.
> 
> Commit a0ae0240 (ARM: kernel: add device tree init map function) introduced the 
> following requirement according to Documentation/devicetree/bindings/arm/cpus.txt:
> "For the ARM architecture every CPU node must contain the following properties:
> 
> - device_type:	must be "cpu" 
> 
> Pass the 'device_type' property for each cpu node, so that we can have all the 
> four cores correctly reported again.
> 
> Cc: <stable@vger.kernel.org> #3.10
> Reported-by: Mike Loebl <mloebl@gmail.com> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Lorenzo had commit 7925e89 (ARM: dts: imx: cpus/cpu nodes dts updates)
fixing up thing, which has just hit the mainline.  But it seems we were
unaware of this user space regression and did not apply the fix to 3.10.
Now we have to apply it for 3.10 via stable tree.

Shawn
