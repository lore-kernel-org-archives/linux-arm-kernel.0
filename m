From: stigge@antcom.de (Roland Stigge)
Date: Fri, 07 Dec 2012 13:06:44 +0100
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <20121207103643.34ca6dc5@pyramind.ukuu.org.uk>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
 <20121207103643.34ca6dc5@pyramind.ukuu.org.uk>
Message-ID: <50C1DBD4.1040007@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 11:36 AM, Alan Cox wrote:
>> * Device interface for userland access (alternative to sysfs)
> 
> Currently we can set different permissions on different GPIO lines. Your
> driver change drives a truck through this facility.
> 
> I'm not sure there is an elegant way to snoop on the permissions set
> on the sysfs gpio nodes and the driver also breaks managing GPIO rights
> via smack/selinux/apparmor and assigning specific gpio lines to specific
> pieces of user space code.

Right. It's difficult to synchronize sysfs and dev node permissions from
the kernel. But since those permissions are set up and maintained from
userspace, maybe we can leave it to the respective facilities there?

Regarding different permissions of individual GPIOs that could end up in
a single GPIO block: You can group GPIOs into separate blocks that are
supposed to group with the same permissions. Especially, you don't need
to put all GPIOs of one gpio_chip into one block.

And finally, you are not forced to use such blocks. Use it optionally
where you group GPIOs into one bus or n-bit interface. E.g., you
typically won't give different permissions to the different lines on an
SD card interface.

Anyway - suggestions (and specific requests for necessary features of
the device interface) welcome!

Thanks in advance,

Roland
