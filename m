From: uwe@congenio.de (Dr. Uwe Meyer-Gruhl)
Date: Fri, 29 May 2015 08:16:39 +0200
Subject: [PATCH 0/1] mv643xx_eth: Disable TSO by default
In-Reply-To: 1415176766.31613.7.camel () hellion ! org ! uk
Message-ID: <55680447.4070503@congenio.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Nov 05, 2014 at 08:39:26AM +0000, Ian Campbell wrote:
>> On Tue, 2014-11-04 at 15:20 +0100, Karl Beldan wrote:
>>> On Sat, Nov 01, 2014 at 12:30:19PM -0300, Ezequiel Garcia wrote:
>>>> Several users ([1], [2]) have been reporting data corruption
>>>> with TSO on Kirkwood platforms (i.e. using the mv643xx_eth
>>>> driver).
>>>>
>>>> Until we manage to find what's causing this, this simple patch  will make
>>>> the TSO path disabled by default. This patch should be queued
for stable,
>>>> fixing the TSO feature introduced in v3.16.
>>>>
>>>> The corruption itself is very easy to reproduce: checkingmd5sum on a mounted
>>>> NFS directory gives a different result each time. Same tests  using the mvneta
>>>> driver (Armada 370/38x/XP SoC) pass with no issues.
>>>>
>>>> Frankly, I'm a bit puzzled about this, and so any ideas ordebugging hints
>>>> are well received.
>>>>
>>>
>>> Hi,
>>>
>>> Can you try this :
>>
>> It fixes things for me, thanks!
>>
>> Tested-by: Ian Campbell <ijc@hellion.org.uk>
>>
>
> Good thing, thanks for your feedbak Ian !
>
> Karl --

That would be a good thing - although: Neither the patch to disable TSO
altogether nor the one that fixes the underlying problem actually made
it to the official kernel source tree, so it is still present in all 
kernels > 3.16 - I just stumbled over this in the current 4.0.4 version.

The fixes in the thread
http://marc.info/?l=linux-netdev&m=141517941900547&w=2 are not
applicable any more to the current driver from the 4.0 kernel, as the
whole respective logic seems to have been changed meanwhile, sadly 
without fixing the problem. Disabling TSO completely still works, though.

Can someone in the know please suggest a working fix to the kernel
maintainers, preferably one that does not resort to disable TSO?


Uwe
--

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3740 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/a14a7b4f/attachment.p7s>
