From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Jul 2014 09:59:51 +0800
Subject: [PATCH] ARM: imx: build cpu_is_imx6sl function conditionally
In-Reply-To: <53B5983A.8030107@cogentembedded.com>
References: <4295402.oOSEcbAj2f@wuerfel> <53B5983A.8030107@cogentembedded.com>
Message-ID: <20140704015949.GI30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 09:51:54PM +0400, Sergei Shtylyov wrote:
> >@@ -156,7 +156,11 @@ extern unsigned int __mxc_cpu_type;
> >  #ifndef __ASSEMBLY__
> >  static inline bool cpu_is_imx6sl(void)
> >  {
> >+#ifdef CONFIG_SOC_IMX6SL
> >  	return __mxc_cpu_type == MXC_CPU_IMX6SL;
> >+#else
> >+	return 0;
> 
>    s/0/false/.
> 
> >+#endif
> 
>    Also, #ifdef's in a function body are ugly.

Okay, I fixed it up as below.

#ifdef CONFIG_SOC_IMX6SL
static inline bool cpu_is_imx6sl(void)
{
        return __mxc_cpu_type == MXC_CPU_IMX6SL;
}
#else
static inline bool cpu_is_imx6sl(void)
{
        return false;
}
#endif

Shawn
