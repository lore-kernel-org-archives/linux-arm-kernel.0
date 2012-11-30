From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 30 Nov 2012 06:34:57 +0000 (UTC)
Subject: nfs root not responding?
Message-ID: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, list

I just enabled the network in the kernel and trying to load a rootfs
from remote nfs server.  The kernel did the DHCP succeed and got the
ip and other network parameters.  But it then keep always complaining
that "nfs server not responding" and the login prompt does not show up.

--------------------------------------------------------------------
AX88796B: Restore PHY default settingAX88796B:  The media mode is autosense.
eth0: link up, 100Mbps, Full-duplex
Sending DHCP requests ..,. OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.86.11.136
IP-Config: Complete:
     device=eth0, addr=10.86.11.136, mask=255.255.255.0, gw=10.86.11.1
     host=10.86.11.136, domain=ap.bm.net, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=10.86.11.107, rootpath=
device: '0:9': device_add
VFS: Mounted root (nfs filesystem) on device 0:9.
Freeing init memory: 104K

nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
fs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 OK
... (skipped many duplications)
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 not responding, still trying
nfs: server 10.86.11.107 OK
Starting logging: OK
Initializing random number generator... read-only file system
detected...done
Starting network...
ip: RTNETLINK answers: File exists
...
-----------------------------------------------------


My kernel version is 3.4.19 built for ARM s3c2410, the kernel command
line is:
"ignore_loglevel console=ttySAC0,115200 ip=dhcp root=/dev/nfs rw
nfsroot=10.86.11.107:/nfs.exp/ffc1000.root,v3 nfsrootdebug"
And, I also tried with:
"ignore_loglevel console=ttySAC0,115200 ip=dhcp root=/dev/nfs ro
nfsroot=10.86.11.107:/nfs.exp/ffc1000.root nfsrootdebug"
but seems that the result gets no change.

And, below is my kernel configuration related to NFS:

------------------------------
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_V4_1 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
-----------------------------

I tested my NFS server, it should be fine since I can mount the same
exporting directory from another linux machine. 

For the problem, the most strange things that I saw the VFS says "VFS:
Mounted root (nfs filesystem) on device 0:9.", so I think the NFS
mounting has already done. Why still has errors?

What's possible causes and where should I go to check?

Thanks in advance!

- 
woody
I can't go back to yesterday - because I was a different person then.
