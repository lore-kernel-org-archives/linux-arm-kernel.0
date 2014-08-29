From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Fri, 29 Aug 2014 10:57:05 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <53FDB649.2070506@gmail.com>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B7FgzB7ThVyV2Vk7wTwYgjRWjEnkkAN5uwwKMaBKq1yg@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
 <53F11FF6.8030303@gmail.com>
 <CAOMZO5CDvQDD7gVLFStwv4MPrUyqZE3sEDZwb0gukkXujYG-6Q@mail.gmail.com>
 <53F2E89B.80009@gmail.com> <53F5BE3D.5070209@gmail.com>
 <CAOMZO5A3CgaVCKxNDG-zEdwprYdRDXD_XZ2ikW+mns-iieYHsg@mail.gmail.com>
 <53F71D1B.8090004@gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043578CB2@ALVA-EXMB04.alv.autoliv.int>
 <53FDB649.2070506@gmail.com>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB80435790DF@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Iain,

> Interesting. We obviously have some differences in how we boot, my
> changes to your config to get it to boot basically amount to reverting the
> patch you attached and then enabling sata and mmc. So far I've been unable
> to get your config to fail.

Our version of U-boot doesn't support specifying a device tree separate from
the kernel, so we append it to the end of the kernel binary. We also enable
automatic configuration of IP addresses (CONFIG_IP_PNP). Our bootargs are:
console=ttymxc1,115200
ip=192.168.2.157:192.168.2.1:192.168.2.1:255.255.255.0:armcard:eth0:on
earlyprintk enable_wait_mode=off

> It would be good to know what makes my config work for you, I don't think
> I've done anything special with it.

With a couple of modifications (attached) we have been able to get your
config running on our Zynq boards as well, solving our ethernet issues.

The serial port and ethernet are essentially the only things we use. No disks,
no graphics, no USB, etc. which is why we tried to reduce the kernel
configuration to a bare minimum. We have no idea which disabled and/or
enabled options that are causing the stalls.

Best regards,
Mattis Lorentzon

***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.patch
Type: application/octet-stream
Size: 2670 bytes
Desc: config.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/479869c2/attachment.obj>
