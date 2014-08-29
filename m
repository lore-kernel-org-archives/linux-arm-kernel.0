From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 29 Aug 2014 08:30:05 -0300
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <C4A61A5CA4AD2246942F4BA6F20ACB80435790DF@ALVA-EXMB04.alv.autoliv.int>
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
 <C4A61A5CA4AD2246942F4BA6F20ACB80435790DF@ALVA-EXMB04.alv.autoliv.int>
Message-ID: <CAOMZO5CY7cDRspdgcPKr0LVBx3PGsBu5jGeQk+_DdVnvL_sSEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mattis,

On Fri, Aug 29, 2014 at 7:57 AM, Mattis Lorentzon
<Mattis.Lorentzon@autoliv.com> wrote:
> Iain,
>
>> Interesting. We obviously have some differences in how we boot, my
>> changes to your config to get it to boot basically amount to reverting the
>> patch you attached and then enabling sata and mmc. So far I've been unable
>> to get your config to fail.
>
> Our version of U-boot doesn't support specifying a device tree separate from
> the kernel, so we append it to the end of the kernel binary. We also enable
> automatic configuration of IP addresses (CONFIG_IP_PNP). Our bootargs are:
> console=ttymxc1,115200
> ip=192.168.2.157:192.168.2.1:192.168.2.1:255.255.255.0:armcard:eth0:on
> earlyprintk enable_wait_mode=off

I suppose that this 'enable_wait_mode=off' is a left over from the
time you used the FSL BSP.

This is not needed in mainline.

>> It would be good to know what makes my config work for you, I don't think
>> I've done anything special with it.
>
> With a couple of modifications (attached) we have been able to get your
> config running on our Zynq boards as well, solving our ethernet issues.
>
> The serial port and ethernet are essentially the only things we use. No disks,
> no graphics, no USB, etc. which is why we tried to reduce the kernel
> configuration to a bare minimum. We have no idea which disabled and/or
> enabled options that are causing the stalls.

It's good to hear you do not have the lockups anymore, but this is
still a big mistery for us as we have not yet understood the root
cause and what is the 'guilty' kernel config option that makes things
FEC to work unreliably.
