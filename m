From: mk@drkrebs.de (Markus Krebs)
Date: Fri, 14 Nov 2014 16:01:29 +0100
Subject: Network timing (?) problems since kernel 3.12
In-Reply-To: <5463C356.50505@drkrebs.de>
References: <545F852D.5040209@drkrebs.de> <20141109155502.GA10013@lunn.ch>
 <545F9CC5.6070709@drkrebs.de> <20141112194805.GA27092@schnuecks.de>
 <5463C356.50505@drkrebs.de>
Message-ID: <54661949.3010905@drkrebs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.11.2014 um 21:30 schrieb Markus Krebs:
> Am 12.11.2014 um 20:48 schrieb Simon Baatz:
>> Hi Markus,
>>
>> On Sun, Nov 09, 2014 at 05:56:37PM +0100, Markus Krebs wrote:
>>> Am 09.11.2014 um 16:55 schrieb Andrew Lunn:
>>>
>>>>> I'm using a Sheevaplug (Marvell Kirkwood) with an USB-Stick for
>>>>> storage as a server. Since kernel 3.12 I'm experiencing various
>>>>> erratic problems when transferring files, especially large or many
>>>>> files at the same time, over the network (ssh complaining about
>>>>> "Corrupted MAC on input" or Windows [over Samba] about corrupt
>>>>> files).
>>>>> Turning "offload check summing" off with ethtool didn't really help.
>>>>
>>>> Try turning off gso.
>>>
>>> Thanks, Andrew; I've tried now but that didn't do the trick either.
>>
>> I am not able to provoke this behaviour on my Sheevaplug using a
>> stock 3.12.32 kernel (but that does not mean much.  Just did some
>> quick tests by copying large files from an USB stick using ssh or
>> netcat).
>>
>> Could you elaborate on the actual kernel and config you are using?
>> Is there a simple testcase that reliably reproduces the behaviour on
>> your box?
>>
>> - Simon
>>
>
> Hi Simon,
>
> the actual working kernel I'm using is "3.11-2-kirkwood #1 Debian
> 3.11.10-1 (2013-12-04) armv5tel". It never fails on anything.
>
> When I upgrade to a newer kernel (3.15, 3.16, 3.17 ..), my testcase
> is/was to do a unison synchronisation run: I synchronize a large
> directory on the server with a backup directory on a Windows machine.
> Unison is invoked from Windows, while the Linux unison server is
> waiting, over ssh. Immediately after invoking unison from Windows, it
> crashes, when the server runs a newer kernel. This is reproduceable.
> Being curious what could be the problem, I have synchronized two Linux
> servers with unison, again over ssh. It then gave the error "Corrupted
> MAC on input".
> This "unison over ssh"-scenario is my testcase, as when copying files,
> the error is not consistently reproduceable.
>
> - Markus
>
>

Hi all,

I don't know what has changed, but with the newest Debian kernel 
[3.16.0-4-kirkwood #1 Debian 3.16.7-2 (2014-11-06)] things seems to work 
better. No errors so far!
Thank you for your investigations!

- Markus
