From: a.heider@gmail.com (Andre Heider)
Date: Fri, 20 May 2016 07:44:06 +0200
Subject: 4.5.0 on sun7i-a20-olinuxino-lime2: libphy: PHY stmmac-0:ffffffff
 not found (regression from rc7)
In-Reply-To: <20160317075202.16b14ed6@arm.com>
References: <56E9413D.9010902@a20.net> <56E945FF.6080005@arm.com>
 <56E94CF4.2060607@arm.com> <56E95B57.1090100@suse.de>
 <56E9776F.3070102@a20.net> <56E99B0C.2070609@arm.com>
 <56E9F2B8.1030605@a20.net> <20160317075202.16b14ed6@arm.com>
Message-ID: <CAHsu+b-t_r93XKLJTUcin6xjhOrFVn3_60vwHkbRt3iHK28CbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Giuseppe, Alexandre, et al.,

On Thu, Mar 17, 2016 at 8:52 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Thu, 17 Mar 2016 00:56:40 +0100
> Bert Lindner <bert@a20.net> wrote:
>> On 2016-03-16 18:42, Marc Zyngier wrote:
>> > On 16/03/16 15:10, Bert Lindner wrote:
>> >> On 2016-03-16 14:10, Andreas F?rber wrote:
>> >>> Am 16.03.2016 um 13:09 schrieb Robin Murphy:
>> >>>> On 16/03/16 11:39, Marc Zyngier wrote:
>> >>>>> On 16/03/16 11:19, Bert Lindner wrote:
...
>> >>>>>> For the board sun7i-a20-olinuxino-lime2, there seems to be a problem
>> >>>>>> with the eth0 PHY in mainline kernel 4.5.0 that developed since
>> >>>>>> 4.5.0-rc7. Ethernet does not work, although eth0 is reported:
...
>> >>>>>> [    9.767125] NET: Registered protocol family 10
>> >>>>>> [   10.357405] libphy: PHY stmmac-0:ffffffff not found
>> >>>>>> [   10.362382] eth0: Could not attach to PHY
>> >>>>>> [   10.366557] stmmac_open: Cannot attach to PHY (error: -19)
...
>> >>> v4 fixes for 4.5 are here:
>> >>>
>> >>> https://patchwork.ozlabs.org/patch/598195/ (revert)
>> >>> https://patchwork.ozlabs.org/patch/598196/
...
>> > Good to know, thanks. Could you also give the potential fix a go (as
>> > mentioned by Andreas)? Just to make sure that whatever gets merged next
>> > will actually fix the issue.
>>
>> Yes sure, it took a while because I had to travel. Confirmed, the
>> v4-for-4.5 fix works well for me, on sun7i-a20-olinuxino-lime2:
>>
>> root at lime2-079f:~# cat /proc/version
>> Linux version 4.5.0-598195-598196-v4 (root at lime2-079f) (gcc version
>> 4.9.1 (Ubuntu/Linaro 4.9.1-16ubuntu6) ) #1 SMP Wed Mar 16 16:44:22 UTC 2016
>>
>> dmesg:
>> [    8.245273] NET: Registered protocol family 10
>> [    9.297406]  RX IPC Checksum Offload disabled
>> [    9.297460]  No MAC Management Counters available
>> [    9.297951] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   16.285658] sun7i-dwmac 1c50000.ethernet eth0: Link is Up -
>> 1Gbps/Full - flow control rx/tx
>> [   16.285798] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>
>> The board is connected to my laptop rather than to a switch, so that
>> might be where the flow control message comes from (not sure). Anyway
>> ethernet works.
>
> Cool, many thanks for taking the time to test and report.
>
> Hopefully Giuseppe will get this merged quickly enough in mainline, and
> it should then trickle into a 4.5-stable release (cc-ing stable on
> these patches would probably be a good idea, BTW).

stmmac is broken on at least Lime2, BananaPi and Cubieboard2 since
v4.5 [0], including all five stable releases :(
The v4.5 patches quoted above are already +4 weeks old, could we
please get them into stable?

Thanks!
Andre

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823493
