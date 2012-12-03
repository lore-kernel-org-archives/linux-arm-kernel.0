From: narkewoody@gmail.com (Woody Wu)
Date: Mon, 3 Dec 2012 02:26:12 +0000 (UTC)
Subject: nfs root not responding?
References: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
 <20121130083252.B4301200171@gemini.denx.de>
 <slrnkbo1et.1p8.narkewoody@zuhnb712.local.com>
Message-ID: <slrnkbo3ca.1p8.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-12-03, Woody Wu <narkewoody@gmail.com> wrote:
> On 2012-11-30, Wolfgang Denk <wd@denx.de> wrote:
>> Dear Woody Wu,
>>
>> In message <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com> you wrote:
>>> 
>>> I just enabled the network in the kernel and trying to load a rootfs
>>> from remote nfs server.  The kernel did the DHCP succeed and got the
>>> ip and other network parameters.  But it then keep always complaining
>>> that "nfs server not responding" and the login prompt does not show up.
>>
>> Try adding "proto=tcp" as mount option and test if this changes
>> anything.
>>
>
> The result is the same after adding "proto=tcp".  A suspicous thing I
> found it, while the nfs was not working, I tried to ping the target from
> another host, but the ping is not reachable.  I then skipped the nfs
> mounting by specifing another kernel command to mount my old but not fully
> workable root image, where I run /bin/sh as init
> (root=/dev/my_old_img_partition init=/bin/sh). After got the command
> prompt, I found the target still not reachable by ping.  Does it mean my
> ethernet driver is not really running? On one side, this can explain the
> nfs problem, but why the dhcp work and did get assigned an IP?
>
>

By enabling the debug output in my Ethernet driver, I captured some
network traffics.


Here are the DHCP part:

---------------dhcp start----------------------------------
Sending DHCP requests .AX88796B:  ax88796b_start_xmit beginning ..
AX88796B:  tx pkt len 590, need 3 pages, free pages 12
AX88796B:  Dump tx pkt 590
ff ff ff ff ff ff 16 e4 f0 eb 73 c5 08 00 45 00 
02 40 00 00 40 00 40 11 38 ae 00 00 00 00 ff ff 
ff ff 00 44 00 43 02 2c 00 00 01 01 06 00 ec 88 
fc 7b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 01 37 08 01 
03 06 0c 0f 11 1a 28 ff 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x50, boundary page 0x4d
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x50, boundary page 0x4e
AX88796B:  Dump rx pkt 344
16 e4 f0 eb 73 c5 00 15 62 ad 05 3f 08 00 45 00 
01 4a ce ad 00 00 ff 11 c0 80 0a 56 0b 01 0a 56 
0b c8 00 43 00 44 01 36 b6 b1 02 01 06 00 ec 88 
fc 7b 00 00 00 00 00 00 00 00 0a 56 0b c8 0a 56 
0a 53 0a 56 0b 01 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 02 01 04 ff 
ff ff 00 3a 04 00 05 46 00 3b 04 00 09 3a 80 33 
04 00 0a 8c 00 36 04 0a 56 0a 53 03 04 0a 56 0b 
01 06 08 0a 56 0a 53 0a 56 0a 54 0f 0a 61 70 2e 
62 6d 2e 6e 65 74 00 ff 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
,AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 590, need 3 pages, free pages 12
AX88796B:  Dump tx pkt 590
ff ff ff ff ff ff 16 e4 f0 eb 73 c5 08 00 45 00 
02 40 00 00 40 00 40 11 38 ae 00 00 00 00 ff ff 
ff ff 00 44 00 43 02 2c 00 00 01 01 06 00 ec 88 
fc 7b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 03 36 04 0a 
56 0a 53 32 04 0a 56 0b c8 37 08 01 03 06 0c 0f 
11 1a 28 ff 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_start_xmit end ..........
.AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 590, need 3 pages, free pages 12
AX88796B:  Dump tx pkt 590
ff ff ff ff ff ff 16 e4 f0 eb 73 c5 08 00 45 00 
02 40 00 00 40 00 40 11 38 ae 00 00 00 00 ff ff 
ff ff 00 44 00 43 02 2c 00 00 01 01 06 00 ec 88 
fc 7b 00 02 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 03 36 04 0a 
56 0a 53 32 04 0a 56 0b c8 37 08 01 03 06 0c 0f 
11 1a 28 ff 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x5c, boundary page 0x50
AX88796B:  Dump rx pkt 344
16 e4 f0 eb 73 c5 00 15 62 ad 05 3f 08 00 45 00 
01 4a ce b0 00 00 ff 11 c0 7d 0a 56 0b 01 0a 56 
0b c8 00 43 00 44 01 36 c8 5a 02 01 06 00 ec 88 
fc 7b 00 00 00 00 00 00 00 00 0a 56 0b c8 00 00 
00 00 0a 56 0b 01 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 05 3a 04 00 
05 46 00 3b 04 00 09 3a 80 33 04 00 0a 8c 00 36 
04 0a 56 0a 53 01 04 ff ff ff 00 03 04 0a 56 0b 
01 06 08 0a 56 0a 53 0a 56 0a 54 0f 0a 61 70 2e 
62 6d 2e 6e 65 74 00 ff 
AX88796B:  Current page 0x5c, boundary page 0x52
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5d, boundary page 0x53
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff 18 a9 05 26 36 11 08 00 45 00 
00 e5 2b f4 00 00 80 11 e1 fa 0a 56 0b 6f 0a 56 
0b ff 00 8a 00 8a 00 d1 cf a8 11 0e c4 05 0a 56 
0b 6f 00 8a 00 bb 00 00 20 45 44 45 4f 46 4b 46 
46 45 49 46 41 45 44 44 49 44 45 44 45 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 45 42 46 41 43 
41 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 e8 03 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 43 4e 5a 55 48 50 43 38 
34 34 00 00 00 00 00 00 06 01 03 10 01 00 0f 01 
55 aa 00 
AX88796B:  Current page 0x5d, boundary page 0x54
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x5d, boundary page 0x55
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff e8 9d 87 b9 09 2a 08 06 00 01 
08 00 06 04 00 01 e8 9d 87 b9 09 2a 0a 56 0b 78 
00 00 00 00 00 00 0a 56 0b 01 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5d, boundary page 0x56
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff d8 d3 85 75 87 1d 08 06 00 01 
08 00 06 04 00 01 d8 d3 85 75 87 1d 0a 56 0b 59 
00 00 00 00 00 00 0a 56 0b 83 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5e, boundary page 0x57
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff c8 0a a9 3a 0e 33 08 06 00 01 
08 00 06 04 00 01 c8 0a a9 3a 0e 33 0a 56 0b 83 
00 00 00 00 00 00 0a 56 0b 59 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5e, boundary page 0x58
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 81 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x5e, boundary page 0x59
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 49 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5e, boundary page 0x5a
AX88796B:  Dump rx pkt 344
16 e4 f0 eb 73 c5 00 15 62 ad 05 3f 08 00 45 00 
01 4a ce b3 00 00 ff 11 c0 7a 0a 56 0b 01 0a 56 
0b c8 00 43 00 44 01 36 c8 5a 02 01 06 00 ec 88 
fc 7b 00 00 00 00 00 00 00 00 0a 56 0b c8 00 00 
00 00 0a 56 0b 01 16 e4 f0 eb 73 c5 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 63 82 53 63 35 01 05 3a 04 00 
05 46 00 3b 04 00 09 3a 80 33 04 00 0a 8c 00 36 
04 0a 56 0a 53 01 04 ff ff ff 00 03 04 0a 56 0b 
01 06 08 0a 56 0a 53 0a 56 0a 54 0f 0a 61 70 2e 
62 6d 2e 6e 65 74 00 ff 
AX88796B:  Current page 0x5e, boundary page 0x5c
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff e8 9d 87 09 29 2a 08 00 45 00 
00 e5 06 bd 00 00 80 11 06 f3 0a 56 0b ae 0a 56 
0b ff 00 8a 00 8a 00 d1 fd dd 11 0e 89 55 0a 56 
0b ae 00 8a 00 bb 00 00 20 45 44 45 4f 46 4b 46 
46 45 49 45 4f 45 43 44 4a 44 45 44 44 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 45 42 46 41 43 
41 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 e8 03 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 43 4e 5a 55 48 4e 42 39 
34 33 00 00 00 00 00 00 06 01 03 10 01 00 0f 01 
55 aa 00 
AX88796B:  Current page 0x5e, boundary page 0x5d
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 60 eb 69 40 69 17 08 06 00 01 
08 00 06 04 00 01 60 eb 69 40 69 17 0a 56 0b 86 
00 00 00 00 00 00 0a 56 0b 01 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  ax88796b_rx_poll end ..........
 OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.86.11.200
IP-Config: Complete:
     device=eth0, addr=10.86.11.200, mask=255.255.255.0, gw=10.86.11.1
     host=10.86.11.200, domain=ap.bm.net, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=10.86.11.107, rootpath=
-----------------dhcp end------------------------------------


And, here are the rootfs part,

----------------rootfs start---------------------------------
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 42, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 42
ff ff ff ff ff ff 16 e4 f0 eb 73 c5 08 06 00 01 
08 00 06 04 00 01 16 e4 f0 eb 73 c5 0a 56 0b c8 
00 00 00 00 00 00 0a 56 0b 6b 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 42, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 42
ff ff ff ff ff ff 16 e4 f0 eb 73 c5 08 06 00 01 
08 00 06 04 00 01 16 e4 f0 eb 73 c5 0a 56 0b c8 
00 00 00 00 00 00 0a 56 0b 6b 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x64, boundary page 0x5e
AX88796B:  Dump rx pkt 60
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 02 00 1c c4 cc fb 59 0a 56 0b 6b 
16 e4 f0 eb 73 c5 0a 56 0b c8 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x64, boundary page 0x5f
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x64, boundary page 0x60
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 4a 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x64, boundary page 0x61
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 4b 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 130, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 130
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 74 00 00 40 00 40 11 0e 9b 0a 56 0b c8 0a 56 
0b 6b aa f8 00 6f 00 60 83 dd 1d db a5 3f 00 00 
00 00 00 00 00 02 00 01 86 a0 00 00 00 02 00 00 
00 03 00 00 00 01 00 00 00 20 01 47 ac ee 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 01 86 a5 00 00 00 03 00 00 00 11 00 00 
00 00 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x66, boundary page 0x62
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff 18 a9 05 27 48 4c 08 00 45 00 
00 e5 49 b5 00 00 80 11 c3 eb 0a 56 0b bd 0a 56 
0b ff 00 8a 00 8a 00 d1 f9 01 11 0e 9a 0d 0a 56 
0b bd 00 8a 00 bb 00 00 20 45 44 45 4f 46 4b 46 
46 45 49 46 41 45 44 44 49 44 44 44 48 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 45 42 46 41 43 
41 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 e8 03 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 43 4e 5a 55 48 50 43 38 
33 37 00 00 00 00 00 00 05 01 03 10 01 00 0f 01 
55 aa 00 
AX88796B:  Current page 0x66, boundary page 0x63
AX88796B:  Dump rx pkt 60
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 02 00 1c c4 cc fb 59 0a 56 0b 6b 
16 e4 f0 eb 73 c5 0a 56 0b c8 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x66, boundary page 0x64
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x66, boundary page 0x65
AX88796B:  Dump rx pkt 70
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 38 00 00 40 00 40 11 0e d7 0a 56 0b 6b 0a 56 
0b c8 00 6f aa f8 00 24 80 22 1d db a5 3f 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 e5 21 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x67, boundary page 0x66
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff e8 9d 87 da d5 24 08 06 00 01 
08 00 06 04 00 01 e8 9d 87 da d5 24 0a 56 0b ba 
00 00 00 00 00 00 0a 56 0b 01 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x68, boundary page 0x67
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 78 03 00 00 80 11 96 05 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b8 c8 a7 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 82, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 82
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 44 00 00 40 00 40 11 0e cb 0a 56 0b c8 0a 56 
0b 6b 03 22 e5 21 00 30 23 0b 83 06 be ae 00 00 
00 00 00 00 00 02 00 01 86 a5 00 00 00 03 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x69, boundary page 0x68
AX88796B:  Dump rx pkt 66
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 34 00 00 40 00 40 11 0e db 0a 56 0b 6b 0a 56 
0b c8 e5 21 03 22 00 20 a9 d5 83 06 be ae 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 142, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 142
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 80 00 00 40 00 40 11 0e 8f 0a 56 0b c8 0a 56 
0b 6b 03 22 e5 21 00 6c 08 2c 84 06 be ae 00 00 
00 00 00 00 00 02 00 01 86 a5 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac ef 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 15 2f 6e 66 73 2e 65 78 70 2f 66 
66 63 31 30 30 30 2e 72 6f 6f 74 00 00 00 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 142, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 142
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 80 00 00 40 00 40 11 0e 8f 0a 56 0b c8 0a 56 
0b 6b 03 22 e5 21 00 6c 08 27 84 06 be ae 00 00 
00 00 00 00 00 02 00 01 86 a5 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac f4 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 15 2f 6e 66 73 2e 65 78 70 2f 66 
66 63 31 30 30 30 2e 72 6f 6f 74 00 00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x7d, boundary page 0x69
AX88796B:  Dump rx pkt 110
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 60 00 00 40 00 40 11 0e af 0a 56 0b 6b 0a 56 
0b c8 e5 21 03 22 00 4c d4 75 84 06 be ae 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 1c 01 00 07 00 be 4b 
12 00 00 00 00 00 61 46 59 d6 be 99 46 ba 84 95 
71 44 f5 dc 4f 76 00 00 00 01 00 00 00 01 
AX88796B:  Current page 0x7d, boundary page 0x6a
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 04 c6 00 00 80 11 09 43 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b8 c8 a7 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x7d, boundary page 0x6b
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x7d, boundary page 0x6c
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 0b 69 00 00 80 11 02 a0 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b8 c8 a7 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x7d, boundary page 0x6d
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 2f 00 00 80 11 4e 3e 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 c2 ea fa 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 41 41 00 00 20 00 01 
AX88796B:  Current page 0x7e, boundary page 0x6e
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 0d 61 00 00 80 11 00 a8 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c7 b7 c8 a8 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 42 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x7e, boundary page 0x6f
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x7e, boundary page 0x70
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 30 00 00 80 11 4e 3d 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 c2 ea fa 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 41 41 00 00 20 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x7e, boundary page 0x71
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 0f 24 00 00 80 11 fe e4 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c7 b7 c8 a8 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 42 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x7e, boundary page 0x72
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 51 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x7e, boundary page 0x73
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 31 00 00 80 11 4e 3c 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 c2 ea fa 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 41 41 00 00 20 00 01 
AX88796B:  Current page 0x7e, boundary page 0x74
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x7e, boundary page 0x75
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 10 74 00 00 80 11 fd 94 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c7 b7 c8 a8 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 42 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x7e, boundary page 0x76
AX88796B:  Dump rx pkt 203
ff ff ff ff ff ff 60 eb 69 40 69 17 08 00 45 00 
00 bd 03 01 00 00 80 11 21 54 0a 56 0b 86 ff ff 
ff ff 11 72 11 72 00 a9 1b d3 4b 55 00 03 00 00 
00 a1 83 00 01 04 12 00 02 81 02 00 00 00 00 09 
01 02 01 00 14 12 00 00 00 00 00 00 00 00 00 4c 
f4 88 24 00 13 ce 39 75 0b 05 02 15 00 03 00 02 
00 01 1f ee 03 02 16 12 cd 05 02 17 00 00 00 00 
00 00 04 2c 06 02 03 00 00 00 0c 31 30 2e 38 36 
2e 31 31 2e 31 33 34 03 02 04 11 72 03 02 05 11 
72 04 02 14 01 00 00 00 02 02 18 ff 81 02 40 00 
00 00 04 04 02 43 00 00 00 01 05 02 44 00 00 00 
00 00 00 00 25 05 02 45 00 00 00 00 4e 32 43 39 
05 02 47 00 00 00 00 00 00 15 2b 
AX88796B:  Current page 0x7f, boundary page 0x77
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 35 00 00 80 11 4e 38 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 be ea fc 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x4c, boundary page 0x78
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x4c, boundary page 0x79
AX88796B:  Dump rx pkt 60
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b c8 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x4c, boundary page 0x7a
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff e8 e0 b7 b5 d7 55 08 06 00 01 
08 00 06 04 00 01 e8 e0 b7 b5 d7 55 0a 56 0b 99 
00 00 00 00 00 00 0a 56 0b 01 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x4c, boundary page 0x7b
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff e8 9d 87 b9 09 2a 08 06 00 01 
08 00 06 04 00 01 e8 9d 87 b9 09 2a 0a 56 0b 78 
00 00 00 00 00 00 0a 56 0b 01 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x4c, boundary page 0x7c
AX88796B:  Dump rx pkt 110
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 60 00 00 40 00 40 11 0e af 0a 56 0b 6b 0a 56 
0b c8 e5 21 03 22 00 4c d4 75 84 06 be ae 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 1c 01 00 07 00 be 4b 
12 00 00 00 00 00 61 46 59 d6 be 99 46 ba 84 95 
71 44 f5 dc 4f 76 00 00 00 01 00 00 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 42, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 42
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 06 00 01 
08 00 06 04 00 02 16 e4 f0 eb 73 c5 0a 56 0b c8 
00 1c c4 cc fb 59 0a 56 0b 6b 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x4c, boundary page 0x7d
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 36 00 00 80 11 4e 37 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 be ea fc 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x4c, boundary page 0x7e
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff 68 b5 99 eb c4 64 08 00 45 00 
00 e5 00 1f 00 00 80 11 0d db 0a 56 0b 64 0a 56 
0b ff 00 8a 00 8a 00 d1 da da 11 0e b0 ee 0a 56 
0b 64 00 8a 00 bb 00 00 20 45 44 45 4f 46 4b 46 
46 45 49 45 4f 45 43 44 4a 44 44 44 42 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 45 42 46 41 43 
41 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 e8 03 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 43 4e 5a 55 48 4e 42 39 
33 31 00 00 00 00 00 00 06 01 03 10 01 00 0f 01 
55 aa 00 
AX88796B:  Current page 0x4c, boundary page 0x7f
AX88796B:  Dump rx pkt 60
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b c8 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 42, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 42
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 06 00 01 
08 00 06 04 00 02 16 e4 f0 eb 73 c5 0a 56 0b c8 
00 1c c4 cc fb 59 0a 56 0b 6b 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 130, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 130
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 74 00 00 40 00 40 11 0e 9b 0a 56 0b c8 0a 56 
0b 6b e7 04 00 6f 00 60 88 20 cd 17 b5 af 00 00 
00 00 00 00 00 02 00 01 86 a0 00 00 00 02 00 00 
00 03 00 00 00 01 00 00 00 20 01 47 ac f4 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 01 86 a3 00 00 00 03 00 00 00 11 00 00 
00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x4e, boundary page 0x4c
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 1a a0 ab ba 87 08 00 45 00 
00 4e c0 37 00 00 80 11 4e 36 0a 56 0b 87 0a 56 
0b ff 00 89 00 89 00 3a 91 be ea fc 01 10 00 01 
00 00 00 00 00 00 20 45 42 46 46 46 44 46 4a 45 
45 46 44 46 47 44 42 44 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x4e, boundary page 0x4d
AX88796B:  Dump rx pkt 70
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 38 00 00 40 00 40 11 0e d7 0a 56 0b 6b 0a 56 
0b c8 00 6f e7 04 00 24 61 8a cd 17 b5 af 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 08 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 82, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 82
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 44 00 00 40 00 40 11 0e cb 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 30 51 e5 2a 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 82, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 82
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 44 00 00 40 00 40 11 0e cb 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 30 51 e5 2a 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x51, boundary page 0x4e
AX88796B:  Dump rx pkt 66
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 34 00 00 40 00 40 11 0e db 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 20 d8 ad 2a 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  Current page 0x51, boundary page 0x4f
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x51, boundary page 0x50
AX88796B:  Dump rx pkt 66
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 34 00 00 40 00 40 11 0e db 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 20 d8 ad 2a 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a8 b7 2b 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 13 00 00 00 01 00 00 00 20 01 47 ac f6 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a8 b6 2b 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 13 00 00 00 01 00 00 00 20 01 47 ac f7 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x57, boundary page 0x51
AX88796B:  Dump rx pkt 122
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 6c 00 00 40 00 40 11 0e a3 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 58 9f 20 2b 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 
80 00 00 00 10 00 00 00 80 00 00 00 80 00 00 00 
10 00 00 00 10 00 00 00 07 ff ff ff ff ff 00 00 
00 01 00 00 00 00 00 00 00 1b 
AX88796B:  Current page 0x57, boundary page 0x52
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x57, boundary page 0x53
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 81 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x57, boundary page 0x54
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 49 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x57, boundary page 0x55
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x57, boundary page 0x56
AX88796B:  Dump rx pkt 122
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 6c 00 00 40 00 40 11 0e a3 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 58 9f 20 2b 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 
80 00 00 00 10 00 00 00 80 00 00 00 80 00 00 00 
10 00 00 00 10 00 00 00 07 ff ff ff ff ff 00 00 
00 01 00 00 00 00 00 00 00 1b 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a7 b5 2c 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 14 00 00 00 01 00 00 00 20 01 47 ac f7 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a7 b4 2c 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 14 00 00 00 01 00 00 00 20 01 47 ac f8 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x5a, boundary page 0x57
AX88796B:  Dump rx pkt 98
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 54 00 00 40 00 40 11 0e bb 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 40 58 6c 2c 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 7d 00 00 00 
00 ff 00 00 00 00 00 00 00 01 00 00 00 00 00 00 
00 01 
AX88796B:  Current page 0x5a, boundary page 0x58
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff c8 0a a9 3a 12 13 08 00 45 00 
00 e5 08 2d 00 00 40 11 45 c0 0a 56 0b 71 0a 56 
0b ff 00 8a 00 8a 00 d1 df 46 11 0e ae 68 0a 56 
0b 71 00 8a 00 bb 00 00 20 45 44 45 4f 46 4b 46 
46 45 49 45 4f 45 43 44 4a 44 43 44 42 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 45 42 46 41 43 
41 43 41 43 41 43 41 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 e8 03 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 43 4e 5a 55 48 4e 42 39 
32 31 00 00 00 00 00 00 06 01 03 10 01 00 0f 01 
55 aa 00 
AX88796B:  Current page 0x5a, boundary page 0x59
AX88796B:  Dump rx pkt 98
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 54 00 00 40 00 40 11 0e bb 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 40 58 6c 2c 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 7d 00 00 00 
00 ff 00 00 00 00 00 00 00 01 00 00 00 00 00 00 
00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a6 c7 2d 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac f8 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a6 c6 2d 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac f9 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x5d, boundary page 0x5a
AX88796B:  Dump rx pkt 154
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 8c 00 00 40 00 40 11 0e 83 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 78 d0 90 2d 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 02 00 00 41 ed 00 00 
00 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 
00 00 cc 09 45 4b 92 28 d3 e5 00 00 00 00 00 12 
4b be 50 bb f8 df 21 8e a3 b8 50 b7 20 d8 00 00 
00 00 50 b8 43 a2 2f 09 9b 63 
AX88796B:  Current page 0x5d, boundary page 0x5b
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x5e, boundary page 0x5c
AX88796B:  Dump rx pkt 154
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 8c 00 00 40 00 40 11 0e 83 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 78 d0 90 2d 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 02 00 00 41 ed 00 00 
00 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 
00 00 cc 09 45 4b 92 28 d3 e5 00 00 00 00 00 12 
4b be 50 bb f8 df 21 8e a3 b8 50 b7 20 d8 00 00 
00 00 50 b8 43 a2 2f 09 9b 63 
AX88796B:  Current page 0x5e, boundary page 0x5d
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  ax88796b_rx_poll end ..........
device: '0:9': device_add
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a5 b4 2e 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 13 00 00 00 01 00 00 00 20 01 47 ac f9 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a5 b3 2e 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 13 00 00 00 01 00 00 00 20 01 47 ac fa 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x63, boundary page 0x5e
AX88796B:  Dump rx pkt 122
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 6c 00 00 40 00 40 11 0e a3 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 58 9c 20 2e 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 
80 00 00 00 10 00 00 00 80 00 00 00 80 00 00 00 
10 00 00 00 10 00 00 00 07 ff ff ff ff ff 00 00 
00 01 00 00 00 00 00 00 00 1b 
AX88796B:  Current page 0x63, boundary page 0x5f
AX88796B:  Dump rx pkt 243
ff ff ff ff ff ff 00 17 08 81 09 12 08 00 45 00 
00 e5 ad 1d 00 00 40 11 a0 f2 0a 56 0b 4e 0a 56 
0b ff 00 8a 00 8a 00 d1 18 a0 11 02 00 e6 0a 56 
0b 4e 8a 4b 00 bb 00 00 20 45 4f 46 41 45 4a 44 
49 44 42 44 41 44 4a 44 42 44 43 43 41 43 41 43 
41 43 41 43 41 43 41 43 41 00 20 46 48 45 50 46 
43 45 4c 45 48 46 43 45 50 46 46 46 41 43 41 43 
41 43 41 43 41 43 41 43 41 42 4e 00 ff 53 4d 42 
25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 11 00 00 21 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 21 00 56 00 03 00 01 00 00 00 02 00 32 
00 5c 4d 41 49 4c 53 4c 4f 54 5c 42 52 4f 57 53 
45 00 01 00 80 fc 0a 00 4e 50 49 38 31 30 39 31 
32 00 00 00 00 00 00 00 04 16 03 00 00 00 00 04 
55 aa 00 
AX88796B:  Current page 0x63, boundary page 0x60
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x63, boundary page 0x61
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 49 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x63, boundary page 0x62
AX88796B:  Dump rx pkt 122
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 6c 00 00 40 00 40 11 0e a3 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 58 9c 20 2e 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 
80 00 00 00 10 00 00 00 80 00 00 00 80 00 00 00 
10 00 00 00 10 00 00 00 07 ff ff ff ff ff 00 00 
00 01 00 00 00 00 00 00 00 1b 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a4 c5 2f 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac fa 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 146, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 146
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 84 00 00 40 00 40 11 0e 8b 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 70 a4 c3 2f 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 01 00 00 00 01 00 00 00 20 01 47 ac fc 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x67, boundary page 0x63
AX88796B:  Dump rx pkt 154
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 8c 00 00 40 00 40 11 0e 83 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 78 ce 90 2f 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 02 00 00 41 ed 00 00 
00 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 
00 00 cc 09 45 4b 92 28 d3 e5 00 00 00 00 00 12 
4b be 50 bb f8 df 21 8e a3 b8 50 b7 20 d8 00 00 
00 00 50 b8 43 a2 2f 09 9b 63 
AX88796B:  Current page 0x67, boundary page 0x64
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x67, boundary page 0x65
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 45 85 00 00 80 11 c8 83 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b6 c8 a9 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x68, boundary page 0x66
AX88796B:  Dump rx pkt 154
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 8c 00 00 40 00 40 11 0e 83 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 78 ce 90 2f 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 02 00 00 41 ed 00 00 
00 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 
00 00 cc 09 45 4b 92 28 d3 e5 00 00 00 00 00 12 
4b be 50 bb f8 df 21 8e a3 b8 50 b7 20 d8 00 00 
00 00 50 b8 43 a2 2f 09 9b 63 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x68, boundary page 0x67
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 150, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 150
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 88 00 00 40 00 40 11 0e 87 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 74 a3 99 30 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 04 00 00 00 01 00 00 00 20 01 47 ac fc 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 00 00 00 1f 
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_start_xmit beginning ..........
AX88796B:  tx pkt len 150, need 1 pages, free pages 12
AX88796B:  Dump tx pkt 150
00 1c c4 cc fb 59 16 e4 f0 eb 73 c5 08 00 45 00 
00 88 00 00 40 00 40 11 0e 87 0a 56 0b c8 0a 56 
0b 6b 02 c6 08 01 00 74 a3 96 30 59 c6 00 00 00 
00 00 00 00 00 02 00 01 86 a3 00 00 00 03 00 00 
00 04 00 00 00 01 00 00 00 20 01 47 ac ff 00 00 
00 0c 31 30 2e 38 36 2e 31 31 2e 32 30 30 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 1c 01 00 07 00 be 4b 12 00 00 00 
00 00 61 46 59 d6 be 99 46 ba 84 95 71 44 f5 dc 
4f 76 00 00 00 1f 
AX88796B:  ax_interrupt beginning ..........
AX88796B:  TX int
AX88796B:  RX int
AX88796B:  ax_interrupt end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_start_xmit end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x71, boundary page 0x68
AX88796B:  Dump rx pkt 162
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 94 00 00 40 00 40 11 0e 7b 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 80 cd 7c 30 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 
41 ed 00 00 00 11 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 10 00 00 00 00 00 00 00 10 00 00 00 
00 00 00 00 00 00 cc 09 45 4b 92 28 d3 e5 00 00 
00 00 00 12 4b be 50 bb f8 df 21 8e a3 b8 50 b7 
20 d8 00 00 00 00 50 b8 43 a2 2f 09 9b 63 00 00 
00 03 
AX88796B:  Current page 0x71, boundary page 0x69
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 48 3e 00 00 80 11 c5 ca 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b6 c8 a9 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  Current page 0x71, boundary page 0x6a
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 1c c4 cc fb 59 08 06 00 01 
08 00 06 04 00 01 00 1c c4 cc fb 59 0a 56 0b 6b 
00 00 00 00 00 00 0a 56 0b b2 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x71, boundary page 0x6b
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 4d 76 00 00 80 11 c0 92 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c6 b6 c8 a9 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 43 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x71, boundary page 0x6c
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 81 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x71, boundary page 0x6d
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 49 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x71, boundary page 0x6e
AX88796B:  Dump rx pkt 60
ff ff ff ff ff ff 00 15 62 ad 05 3f 08 06 00 01 
08 00 06 04 00 01 00 15 62 ad 05 3f 0a 56 0b 01 
00 00 00 00 00 00 0a 56 0b 51 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 
AX88796B:  Current page 0x71, boundary page 0x6f
AX88796B:  Dump rx pkt 92
ff ff ff ff ff ff 00 0f 3d 83 ed a1 08 00 45 00 
00 4e 54 7b 00 00 80 11 b9 8d 0a 56 0b ec 0a 56 
0b ff 00 89 00 89 00 3a c7 b5 c8 aa 01 10 00 01 
00 00 00 00 00 00 20 45 44 44 44 44 41 44 41 44 
41 45 45 45 42 44 42 43 41 43 41 43 41 43 41 43 
41 43 41 43 41 43 41 00 00 20 00 01 
AX88796B:  ax88796b_rx_poll end ..........
AX88796B:  ax_interrupt beginning ..........
AX88796B:  ax_interrupt end ..........
AX88796B:  ax88796b_poll beginning ..........
AX88796B:  ax88796b_rx_poll beginning ..........
AX88796B:  Current page 0x71, boundary page 0x70
AX88796B:  Dump rx pkt 162
16 e4 f0 eb 73 c5 00 1c c4 cc fb 59 08 00 45 00 
00 94 00 00 40 00 40 11 0e 7b 0a 56 0b 6b 0a 56 
0b c8 08 01 02 c6 00 80 cd 7c 30 59 c6 00 00 00 
00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 
41 ed 00 00 00 11 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 10 00 00 00 00 00 00 00 10 00 00 00 
00 00 00 00 00 00 cc 09 45 4b 92 28 d3 e5 00 00 
00 00 00 12 4b be 50 bb f8 df 21 8e a3 b8 50 b7 
20 d8 00 00 00 00 50 b8 43 a2 2f 09 9b 63 00 00 
00 03 
-------------nfsroot never ending---------------

Can these captures provide any clue? Thanks in advance!

-- 
woody
I can't go back to yesterday - because I was a different person then.
