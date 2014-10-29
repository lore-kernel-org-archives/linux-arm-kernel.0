From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Oct 2014 15:21:48 +0000
Subject: [PATCHv3 2/5] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141029152148.GM27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 06:40:04PM +0000, Punit Agrawal wrote:
>  arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
> -					   sys_compat.o
> +					   sys_compat.o 			\
> +					   $(addprefix ../../arm/kernel/,	\
> +						opcodes.o)

This is not particularly nice.  While it means that this file gets built
on both arm64 and arm, it means that it routinely won't get tested on
arm64 when changes to it happen.

The second reason it's not nice is that the whole $(addprefix thing
really isn't needed.  You're only adding the prefix to one name.  So,
a simpler way to write it is "../../arm/kernel/opcodes.o".

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
