From: msuchanek@suse.de (Michal =?UTF-8?B?U3VjaMOhbmVr?=)
Date: Tue, 6 Mar 2018 20:21:06 +0100
Subject: [PATCH 1/2] mmc: bcm2835: reset host on timeout
In-Reply-To: <166274019.307112.1520085525833@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
 <166274019.307112.1520085525833@email.1und1.de>
Message-ID: <20180306202106.0abd51ca@kitsune.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 3 Mar 2018 14:58:45 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
> 

> yesterday i finished my stress tests with Raspberry Pi 3.
> 
> Scenario:
> - copy Tumbleweed on SD card
> (openSUSE-Tumbleweed-ARM-JeOS-raspberrypi3.aarch64-2018.02.02-Build1.2.raw,
> Linux 4.14.15)
> - setup locales with yast
> - run zypper update
> - reboot
> - install and remove java 1.8 in a loop for at least 1 hour
> 
> Results of the different SD cards:
> Toshiba uSDHC Class 10 UHS-1 32 GB: PASS
> BASETech uSDHC Class 10 16 GB: PASS
> Samsung uSDHC EVO+ UHS-1 16 GB: PASS
> Samsung uSDHC Class 6 32 GB: PASS
> SanDisk Edge Class 4 16 GB: PASS
> Kingston uSDHC Class 10 UHS-1 32 GB: PASS
> QUMOX uSDHC Class 10 UHS-1 16 GB: FAIL (zypper segfaulted
> permantently) Transcend uSDHC Class 10 UHS-1 32 GB: PASS
> 
> I was never able to reproduce this timeout. 

For the record I was not able to reproduce the issue installing and
removing openjdk-1.7.0 in a loop for an hour on Leap 42.3 system which
is affected by the issue. This was a loop of repeatedly installing and
removing four packages and was executed 68 times. I enabled zypper
package caching to avoid spending time in download.

Thanks

Michal
