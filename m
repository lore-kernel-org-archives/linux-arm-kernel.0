From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 00:31:28 +0000
Subject: iMX31 MBX registers Porting problem
In-Reply-To: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
References: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
Message-ID: <20110131003128.GD27436@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 29, 2011 at 11:48:54PM -0700, Badguy Badguy wrote:
> 2.6.35
> 2.6.38-rc2
>  neither of these worked, provide various dynamic address results for
> the registers,
>  when read do not conform to expected results.
> 
> here are some examples, I am iounmap and kfree when removing correctly
> but I still get a new address for each insert, after removal,
> this does not happen on 2.6.19.2, it's always the same.
> 
> Address: 0xC48A0000
> MBX1_GLOBREG_REVISION: 0x00000000
> 
> Address: 0xC48A8000
> MBX1_GLOBREG_REVISION: 0x00000000
> 
> Address: 0xC48B8000
> MBX1_GLOBREG_REVISION: 0x00000000
> 
> Address: 0xC48C0000
> MBX1_GLOBREG_REVISION: 0x00000000
> 
>  I have been trying to understand the code behind ioremap, and the
> changes involved.

I can't say why you can't access the registers, but as far as the above
goes, please check /proc/vmallocinfo after each insert and remove, and
report anything which looks wrong.

You should see a new entry when you insert, and that entry removed when
you remove your module.  Check that you're calling iounmap() with the
right arguments too.

It might help if you posted a cut-down version of your code which just
demonstrates the problem so others with an iMX31 can try it too.
