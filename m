From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Jun 2012 17:49:20 -0400 (EDT)
Subject: Overriding/concatenating kernel command-line with bootargs from
 dtb?
In-Reply-To: <2050174.dvvKJHKP0J@flexo>
References: <2050174.dvvKJHKP0J@flexo>
Message-ID: <alpine.LFD.2.02.1206081630170.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jun 2012, Florian Fainelli wrote:

> Hi all,
> 
> I have a specific use case, where two boards using the same SoC have different 
> UART speeds, which is something that I have specified in their corresponding 
> dts files. In order to make sure people don't mess up the configuration, I 
> prefer not to rely on the bootloader-supplied kernel-command line.
> 
> I was kind of expecting that ARM_ATAG_DTB_COMPAT + CMDLINE_EXTEND would 
> actually concatenate the kernel command-line with the bootargs provided from 
> dtb.
> 
> Is this something someone else would need? If so, shall we just make that 
> happen when the two config symbols mentionned above are enabled, or shall we 
> introduce a 4th kernel command line handling strategy?

The former please.  The logic in parse_tag_cmdline() needs to be 
duplicated in early_init_dt_scan_chosen().  CONFIG_CMDLINE_FORCE is 
already implemented, so only CONFIG_CMDLINE_EXTEND is missing.


Nicolas
