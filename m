From: zonque@gmail.com (Daniel Mack)
Date: Sun, 17 Nov 2013 23:09:41 +0100
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <52863232.30207@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>	<CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>	<527A7E20.4040107@ti.com>	<527B95E3.9060802@ti.com>	<527B9673.60400@gmail.com>	<527BAF63.10308@ti.com>	<527BB38A.1060609@gmail.com>	<527BB636.60403@ti.com>
 <CANacCWynOaW_xDBCiFaG5vrcTFuOkk43kuu26gvN4-eN2E8R4w@mail.gmail.com>
 <52863232.30207@ti.com>
Message-ID: <52893EA5.7080809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 11/15/2013 03:39 PM, Nishanth Menon wrote:
> To trigger the fail, I created a custom Test case on TI vendor kernel
> based on v3.12 tag:
> On beagleBone-Black
> test scenario (BBB):
> 
>     Boot from SD card
>     ensure firmware is loaded (rev 0x182)
>     run LTP fsstress [1] in background on EMMC
>         mkdir -p /tmp/testing
>         mke2fs /dev/mmcblk1p1
>         mount /dev/mmcblk1p1 /tmp/testing
>         fsstress -d /tmp/testing p 4 -n 1000 -l0 -v >/dev/null &
>     run ping in the background (to add yet another interface)
>     run memtester[2] (70% of free memory)
>         memtester 343M >/dev/null &
>         sleep 10 (to allow memtester to start up properly)
>     start=`date`;i=0; while [ 1 ]; do rtcwake -d /dev/rtc0 -m mem -s
> 2; i=$((i + 1)); echo "$i: start =$start, now="`date`; sleep 2; done
> 
> Eventual hang log (using the regular suspend-resume): [3] - took close
> to two days of testing to trigger this.
> 
> Moving to a suspend_late and resume_early such as in [4], it passed
> the test for over 4 days now.

Wow, that's an intense test that you have there :)

> Daniel,
> will be good if you could post [4] for comments if you think that is
> the right thing to do and helps solve the issue you saw as  well.

Alright, will do!


Thanks a lot,
Daniel
