From: gregkh@linuxfoundation.org ('gregkh@linuxfoundation.org')
Date: Sun, 2 Mar 2014 19:08:21 -0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <35FD53F367049845BC99AC72306C23D102844605F38F@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
 <53104ECA.4010702@freescale.com>
 <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
 <20140228163304.GA15614@kroah.com>
 <35FD53F367049845BC99AC72306C23D102844605F38F@CNBJMBX05.corpusers.net>
Message-ID: <20140303030821.GA16732@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 10:51:23AM +0800, Wang, Yalin wrote:
> Hi  greg,
> 
> I am sorry,
> I make a mistake ,
> You are right ,
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/usb/gadget/f_mass_storage.c?h=master#n2724
> 
> this one should not changed to use vmalloc,
> the buffer will be used by DMA?

Which is why a wrapper function will never work.

> others should be safe to change:
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound/soc/soc-core.c?h=master#n3772
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_ftp.c?h=master#n603
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_h323_main.c?h=master#n1849
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_irc.c?h=master#n247
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_sane.c?h=master#n195
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/input/evdev.c?h=master#n403

Then send individual patches for these and see what happens.

greg k-h
