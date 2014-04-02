From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 02 Apr 2014 16:20:00 +0100
Subject: mach header files
In-Reply-To: <416b29756557446199fa6e3b529cd4f0@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <416b29756557446199fa6e3b529cd4f0@HKXPR06MB168.apcprd06.prod.outlook.com>
Message-ID: <533C2AA0.1040601@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/14 16:11, Phil Edworthy wrote:
> Hi,
>
> I am porting the kernel to a new device, for which I've created a new arch/arm/mach-... directory, and I also a clock driver that lives under driver/clk. Everything is all working fine, though I am now cleaning up the code and have a question about mach specific header files.
>
> The clock driver is completely specific to this device, but needs to read from a system register (just for external boot mode pins) to determine some PLL settings. This register is in a block of system registers which are also used by the mach code in arch/arm/mach-...
>
> Since the clock driver is specific to the mach, is there any point in specifying the address of this reg in the corresponding dtsi? The format and functionality described by this register would not be the same on any other device.
>
> If I don't specify the address of the register in the dtsi, I think it would be best to have a common header file for all of the system registers. I've seen some drivers, e.g.  exynos-cpufreq.c, doing this by including files from mach-exynos/include/mach. Is that the right way to do this?
>
> Thanks
> Phil
>
>
> This message is intended only for the use of the addressee(s) and may contain confidential and/or legally privileged information. If you are not the intended recipient, you are hereby notified that any dissemination of this email (including any attachments thereto) is strictly prohibited. If you have received this email in error, please notify the sender immediately by telephone or email and permanently destroy the original without making any copy. Please note that any material and advice from this mail is provided free of charge and shall be used as an example for demonstration purposes only.
> RENESAS MAKES NO WARRANTIES THAT THE USAGE OF INFORMATION OR ADVICE FROM THIS E-MAIL WILL NOT INFRINGE ANY INTELLECTUAL PROPERTY RIGHTS (E.G. PATENTS, COPYRIGHTS). RENESAS CANNOT GUARANTEE BUG FREE OPERATION AND THE RECIPIENT WILL USE AND/OR DISTRIBUTE IT ONLY AT HIS OWN RISK. IN NO EVENT SHALL RENESAS BE LIABLE FOR ANY DAMAGE. The communication with Renesas Electronics Europe Ltd does not amend any written agreement in place.

This is my least favourite method of law-breaking.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
