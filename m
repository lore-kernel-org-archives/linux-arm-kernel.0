From: govindraj.ti@gmail.com (Govindraj)
Date: Tue, 3 Jan 2012 19:42:46 +0530
Subject: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304BB42@DBDE01.ent.ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
 <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
 <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D1214304BAD3@DBDE01.ent.ti.com>
 <CAAL8m4yhtUNjoKwECnQEYNoaL-M+RaHXACanAeJW64DPsJ_hWg@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D1214304BB42@DBDE01.ent.ti.com>
Message-ID: <CAAL8m4z-AsVzfubqBy=nP6EN=m6MjTma1+50+aywQ=hmoF6Ejg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2012 at 5:22 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Tue, Jan 03, 2012 at 16:01:52, Govindraj wrote:
>> >
>> > I have basic suspend-resume working on it. Strangely this works irrespective
>> > of the value of tty_dev wakeup entry. Do you know if this is expected on OMAP?
>> >
>>
>> AFAIK yes.
>
> Ok.
>
>>
>> > The other issue concerning runtime PM is that as soon as I set a non-zero to
>> > the autosuspend_delay_ms I get some garbage characters and eventually the
>> > console stops responding.
>> >
>> > [root at arago /]# cat .../omap_uart.0/power/autosuspend_delay_ms
>> > -1
>> > [root at arago /]# echo 3000 > ?KW???+???+wU.???,z,??.??osuspend_delay??????...
>> > [root at arago /]# <- No response after some time
>> >
>>
>> try enabling CONFIG_CPU_IDLE for pm qos_usage from uart driver.
>>
>
> Its enabled.

I checked on Beagle-xm with latest LO master I don't see that issue.

Lo master commit used
commit: 6489f6de3a219dfd23a91261eea1b09fba7ae128

Logs:
http://pastebin.pandaboard.org/index.php/view/55509914

--
Thanks,
Govindraj.R
