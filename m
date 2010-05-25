From: seth.forshee@gmail.com (Seth Forshee)
Date: Tue, 25 May 2010 12:27:40 -0500
Subject: zImage works, but not vmlinux
In-Reply-To: <4BFBF015.6000008@gmail.com>
References: <4BFBF015.6000008@gmail.com>
Message-ID: <20100525172740.GA24294@ubuntu-workstation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 11:43:17AM -0400, f. achkar wrote:
> Hi,
> I have tried to send this message some part of it was ignored, resending
> sorry ...
> 
> greetings,
> I'm newbie to arm linux, so pls if my issue is already addressed just
> point me to that reference. I'm trying to learn, but couldn't pass the
> following stage:
> I have a s3c245 based board, I have a working compressed kernel image
> zImage, this image boots properly via u-boot-1.1.6, however I simply
> failed to load (i.e., boot vmlinux) via u-boot directly from SDRAM.

vmlinux is an ELF image.  When you run your boot command the bootloader
is (probably) just branching execution to the address you're supplying,
which contains ELF header data rather than executable instructions.
