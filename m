From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 17:57:53 +0800
Subject: [PATCH 0/6] footbridge consolidation patches
In-Reply-To: <20110613082044.GA9393@n2100.arm.linux.org.uk>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
	<20110613082044.GA9393@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikTveEyKkYay9_4Y0SX6_V-DF7wfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 4:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 13, 2011 at 02:39:39PM +0800, Bryan Wu wrote:
>> When trying to convert old leds event driver to led trigger drivers, I reviewed
>> the code of mach-footbridge. move seperated PCI code and leds code into a
>> single board files like other machines.
>
> This looks like it breaks all these when CONFIG_PCI=n. ?In that case,
> we would avoid building the PCI supporting files. ?However, with your
> merged files, we build it anyway and end up with undefined calls to
> the PCI subsystem.
>
> The code is separated to avoid that, and to avoid ifdefs.
>

Yes, indeed.

Actually, my plan is to move code into one board file per machine but
it needs ifdef which I missed in my patches.
If you think the first 4 patches are useless, I think we can ignore them.

> I'm not entirely sure what the point of this patch set is, because it
> mostly just moves the code into one file per platform and doesn't
> consolidate anything between the platforms themselves.
>

I just start to convert the led drivers into a common framework like
gpio leds or led triggers. mach-footbridge is the my first step. I
will move to other subarch later after you review this patchset.

Thanks,
-Bryan
