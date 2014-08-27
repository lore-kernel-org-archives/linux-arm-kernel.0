From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Wed, 27 Aug 2014 06:32:39 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <53F71D1B.8090004@gmail.com>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
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
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB8043578CB2@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iain, Russell and Fabio,

> The config is attached. Note that there's a lot of additional stuff enabled as
> I'm aiming for a single general purpose kernel that covers i.MX6, AM3359,
> Allwinner A10/A20 along with several versions of boards using those
> particular SoCs.
> 
> Same kernel binary on all the boards I've tried this on, only real differences
> will be the devicetree and u-boot

Amazingly we have been able to run a complete nightly test on eight i.MX6
boards without hickups using Iain's config! We had to modify it slightly to get
it to boot, please find attached patch and Iain's patched config.

On Russell's suggestion we also began to disable flow control on the machines.
However it did not seem to make a difference because all our Zynq cards
stalled during the same test run (using our own Zynq config).

Iain's config seems promising and we will continue to run tests during the
next couple of days. We will also try to adapt Iain's config to our Zynq board.

Many thanks for all suggestions, patches and configs so far!

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
Size: 692 bytes
Desc: config.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/44ff0458/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gzip
Size: 23527 bytes
Desc: config.gz
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/44ff0458/attachment-0001.bin>
