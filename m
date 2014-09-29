From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 29 Sep 2014 12:25:05 +0200
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <CACna6ry91b3wcHsG4C-td+STPuiaH7oaAcQuKiKdhud+jctUeA@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
 <CACna6ry91b3wcHsG4C-td+STPuiaH7oaAcQuKiKdhud+jctUeA@mail.gmail.com>
Message-ID: <CACna6rwz6e0Hc_Ho+dRBTzwNu6_J0Xn9B_76FH0YWDosV-meiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2014 11:53, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 29 September 2014 08:36, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> 1) The main urgent issue: broken auto-loading
>> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.html
>> Problem: m25p80.c references spi_nor_ids (from external file)
>> Short-term solution: duplicate IDs in the m25p80.c
>>
>> Ben: just like Brian, I think the patch like this one (
>> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
>> ) is the way to go. However few comments:
>
> I started wondering... would this be possible to fix all m25p80 users
> instead? Make them always specify modalias as "m25p80" and then
> provide platform_data if needed?
>
> Has anyone checked in how many places we use "wrong" (or should I say
> "weird") modaliases? I guess some would need to grep kernel for all
> possible names.

I did some (e)grepping, it seems we have:
1) Only 6 references (modalias) in arch/mips/ath79/
2) About 57 references (compatible) in arch/arm/boot/dts/
3) About 32 references (compatible) in arch/powerpc/boot/dts/

However it seems there is no way to provide platform_data in Device
Tree files. So we have to support compatible (modalias) for now I
guess.

The list (if someone would like to check) of used names in archs:
m25p128 m25p16 m25p32 m25p40 m25p64
mx25l12805d mx25l1606e mx25l25635e mx25l4005a mx25l6405d mx66l51235l
n25q128a11 n25q128a13 n25q512a
s25fl008k s25fl256s1 s25fl512s s25sl064a s25sl12801
sst25vf016b sst25vf032b sst25vf040b sst25wf040
w25q128 w25q256 w25q32 w25q32dw w25q80bl w25x80

-- 
Rafa?
