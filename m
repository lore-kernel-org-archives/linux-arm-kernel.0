From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Fri, 19 Jan 2018 00:25:31 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOcK=CNuopm0bq3s-jb2MJ0hHhLyYC1h3zquO__syN2=tU_nKQ@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
 <CAOcK=CNuopm0bq3s-jb2MJ0hHhLyYC1h3zquO__syN2=tU_nKQ@mail.gmail.com>
Message-ID: <513e5b07-0209-0d30-f8e2-5ff1799d8a2d@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 19.01.2018 00:17, Markus Rathgeb wrote:
>     Hmm, did you get reports or checked that it actually hangs?
> 
>     As far as I remember last time I ran a kernel without Peter's power
>     sequence library on this board it only wasn't able to communicate with
>     the on-board USB hub (and devices behind it), but besides this was
>     able to boot successfully.
>     But my memory may be wrong since it was some time ago.
> 
> 
> Hi,
> this has been reported by me.
> 
> Here my initial message and the attachments:
> 
> Hi,
> after updating the linux system on my Udoo Quad it does not boot successful anymore.
> I've been inventing some time to gather information.
> 
> The system has been working "normal" using the kernel 4.12.10.
> With kernel 4.13(.0) it does not work "normal" (problem description follows shortly) anymore.
> The problem still exist in 4.15-rc7.
> 
> So, starting with 4.13 the kernel hangs / system freezes before the root filesystem gets mounted.
> See attached boot-log-4.13.0-freeze.txt
> 
> If I add the parameter "ip=dhcp" to the kernel command line the kernel does not freezes anymore, the root is mounted and the init system is started.
> See attached boot-log-4.13.0-workaround.txt
> 
> The other problem is that starting with 4.13 the system freeze if I load the "rt2800usb" kernel module.
> 
> Please let me know if I could add more information or could do some further tests etc.

Does applying Fabio's patch to the freezing 4.13 or 4.15-rc kernel cause it to boot
successfully?

> Best regards,
> Markus
> 

Best regards,
Maciej
