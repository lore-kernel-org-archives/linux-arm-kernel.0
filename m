From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 00:20:38 +0100
Subject: [PATCH] ARM: proc-v7.S: Adjust stack address when XIP_KERNEL
In-Reply-To: <1454105474-3009-1-git-send-email-chris.brandt@renesas.com>
References: <1454105474-3009-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <42779466.8cExHmvANB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 January 2016 17:11:14 Chris Brandt wrote:
> When XIP_KERNEL is enabled, the virt to phys address translation for RAM
> is not the same as the virt to phys address translation for .text.
> The only way to know where physical RAM is located is to use
> PLAT_PHYS_OFFSET.
> The MACRO will be useful for other places where there is a similar problem.
> 
> Written by Nicolas Pitre
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 

I have not verified the contents of the patch, but have two comments on the
submission form:

- replace the 'Written by Nicolas Pitre' sentence with a 'From: Nicolas
  Pitre <nico@linaro.org>' line as the first line of the changelog text,
  followed by an empty line, so that 'git am' can set the correct author
  field.

- put your Signed-off-by: line after Nico's for correct documentation
  of who sent what.

	Arnd
