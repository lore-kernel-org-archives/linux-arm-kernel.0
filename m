From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Oct 2017 11:08:50 +0100
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
Message-ID: <20171004100641.GA23092@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 04:25:58PM +0900, Itaru Kitayama wrote:
> Hi,

Hi,

> defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
> messages below:
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...

These are all message from the EFI stub. It's likely that we get into
the kernel proper, but it dies before bringing up the usual console.

Can you try booting with 'earlycon' on the kernel commandline? That
might get some early boot-time console output.

Thanks,
Mark.
