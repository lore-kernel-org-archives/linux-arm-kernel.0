From: stewart@linux.vnet.ibm.com (Stewart Smith)
Date: Wed, 13 Jul 2016 14:59:51 +1000
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160712221804.GV1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
Message-ID: <87twfunneg.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
>> I'm not an expert on DTB, so I can't provide an example of code
>> execution, but you have already mentioned the /chosen/linux,stdout-path
>> property. If an attacker redirects the bootloader to an insecure
>> console, they may get access to the system that would otherwise be
>> impossible.
>
> I fail to see how kexec connects with the boot loader - the DTB image
> that's being talked about is one which is passed from the currently
> running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
> also ARM64) that's a direct call chain which doesn't involve any
> boot loader or firmware, and certainly none that would involve the
> passed DTB image.

For OpenPOWER machines, kexec is the bootloader. Our bootloader is a
linux kernel and initramfs with a UI (petitboot) - this means we never
have to write a device driver twice: write a kernel one and you're done
(for booting from the device and using it in your OS).

-- 
Stewart Smith
OPAL Architect, IBM.
