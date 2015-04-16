From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 16 Apr 2015 15:15:25 -0500
Subject: [PATCH v2 3/9] ARM: dts: add imx7d soc dtsi file
In-Reply-To: <1429211860-14438-4-git-send-email-Frank.Li@freescale.com>
References: <1429211860-14438-1-git-send-email-Frank.Li@freescale.com>
 <1429211860-14438-4-git-send-email-Frank.Li@freescale.com>
Message-ID: <5530185D.5040108@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2015 02:17 PM, Frank.Li at freescale.com wrote:
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		arm,cpu-registers-not-fw-configured;

Just checking -- do you definitely need this property?  If so, the VDSO
won't be able to service gettimeofday/clock_gettime.
