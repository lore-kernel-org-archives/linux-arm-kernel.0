From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Jun 2012 09:34:33 -0500
Subject: Overriding/concatenating kernel command-line with bootargs from
 dtb?
In-Reply-To: <2050174.dvvKJHKP0J@flexo>
References: <2050174.dvvKJHKP0J@flexo>
Message-ID: <4FD601F9.8020201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2012 02:55 AM, Florian Fainelli wrote:
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
> 
> Thank you for your answers.

There was a patch to do this:

http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg10448.html

Please comment if this works for you.

Rob
