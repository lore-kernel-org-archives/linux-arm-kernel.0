From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 9 Jan 2015 10:02:50 +0100
Subject: [GIT PULL] at91: fixes for 3.19 #1 (bis)
In-Reply-To: <20150108224150.GB13612@quad.lixom.net>
References: <1420456477-18204-1-git-send-email-nicolas.ferre@atmel.com>
 <20150108224150.GB13612@quad.lixom.net>
Message-ID: <54AF993A.7070707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/01/2015 23:41, Olof Johansson a ?crit :
> On Mon, Jan 05, 2015 at 12:14:37PM +0100, Nicolas Ferre wrote:
>> Arnd, Olof, Kevin,
>>
>> This is the rebase of my previous pull-request on top of 3.19-rc1. As said at
>> the time of my early messages, I was waiting for the arm-soc *and* pinctrl
>> material to reach Linus T.'s tree before sending this pull-request. In fact
>> this sequence was needed for the gpio header removal. The little patch about
>> #include deletion just follows an earlier merge conflict in arm-soc tree: I was
>> also waiting for this moment before sending the definitive fix, just to be
>> sure.
>>
>> In comparison with the previous pull-request, I also added a tiny correction of
>> the sama5d4.dtsi timer entry. All the rest is pretty straightforward.
>>
>> Thanks, best regards,
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes
>>
>> for you to fetch changes up to 0e049c66ebf56a415cadd6c593b7ee0a2cb9d19d:
>>
>>   ARM: at91/dt: sama5d4: fix the timer reg length (2015-01-05 11:07:14 +0100)
>>
>> ----------------------------------------------------------------
>> First fixes batch for AT91 on 3.19 folowing The big cleanup:
>> - removal of unused Kconfig RTC options
>> - GPIO header file is now in same directory as the pinctrl driver
>> - little fix on #includes
>> - removal of DEBUG_LL from the sama5 common defconfig
>> - little fix of reg size in sama5d4.dtsi
>>
>> ----------------------------------------------------------------
>> Bo Shen (1):
>>       ARM: at91/dt: sama5d4: fix the timer reg length
> 
> This is the only fix among these patches, isn't it? The others seem to
> be code removals/cleanups better targeted for 3.20, as far as I can tell.

Well, this is why I sent the first version of this pull-request very
early in the process. I didn't have the possibility to re-send it
earlier on top of -rc1 until this pull-request.

For me, the remaining of a dead Kconfig option, some issues with
DEGUG_LL and to a lesser extend the remaining of dead code are worth
cleaning now. I do have more cleanup patches to come in 3.20, but
waiting more for this simple material to be included is IMHO not
necessary...

I may have some more fixes remaining for 3.19 and will be cautious about
their nature.


Bye,
-- 
Nicolas Ferre
