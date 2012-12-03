From: narkewoody@gmail.com (Woody Wu)
Date: Mon, 3 Dec 2012 01:53:27 +0000 (UTC)
Subject: nfs root not responding?
References: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
 <20121130083252.B4301200171@gemini.denx.de>
Message-ID: <slrnkbo1et.1p8.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-30, Wolfgang Denk <wd@denx.de> wrote:
> Dear Woody Wu,
>
> In message <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com> you wrote:
>> 
>> I just enabled the network in the kernel and trying to load a rootfs
>> from remote nfs server.  The kernel did the DHCP succeed and got the
>> ip and other network parameters.  But it then keep always complaining
>> that "nfs server not responding" and the login prompt does not show up.
>
> Try adding "proto=tcp" as mount option and test if this changes
> anything.
>

The result is the same after adding "proto=tcp".  A suspicous thing I
found it, while the nfs was not working, I tried to ping the target from
another host, but the ping is not reachable.  I then skipped the nfs
mounting by specifing another kernel command to mount my old but not fully
workable root image, where I run /bin/sh as init
(root=/dev/my_old_img_partition init=/bin/sh). After got the command
prompt, I found the target still not reachable by ping.  Does it mean my
ethernet driver is not really running? On one side, this can explain the
nfs problem, but why the dhcp work and did get assigned an IP?


> You may also want to have a look at this FAQ:
> http://www.denx.de/wiki/view/DULG/EthernetIsUnreliable
>
>
> Best regards,
>
> Wolfgang Denk
>


-- 
woody
I can't go back to yesterday - because I was a different person then.
