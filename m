From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 27 Mar 2011 11:09:21 +0200
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <201103271028.56672.anarsoul@gmail.com>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>	<201103270152.45581.marek.vasut@gmail.com>
	<201103271028.56672.anarsoul@gmail.com>
Message-ID: <4D8EFEC1.7010803@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/27/11 09:28, Vasily Khoruzhick wrote:

> On Sunday 27 March 2011 03:52:45 Marek Vasut wrote:
>> On Saturday 26 March 2011 20:51:43 Vasily Khoruzhick wrote:
>>> PXA27x does not like fastbus for some reason, it can hang in
>>> random places when it's enabled. So don't use it to make cpufreq
>>> stable.
>> This is B/S, you're loosing performance!
> I'm losing nothing, without this patch cpufreq does not work stable at all on 
> Zipit Z2.

Possibly, but Z2 is not the only one using PXA27x.
And of course you lose performance, unless you don't care,
because if it does not work at all, you don't care about performance,
but again it is wrong to force all PXA27x based boards to this.

>> I'd suggest module parameter or
>> device- specific callback to toggle use of fastbus on/off.
> Can you test cpufreq without this patch on pxa270-based board with ondemand or 
> conservative governor (or userspace with 104/208/312mhz)? Is it stable? If not 
> then there's no reason to leave fastbus.

cm-x270 and em-x270 work well with fast bus bit set with userspace governor and
with the above frequencies.
I'd check the hardware (especially DRAM).
And I agree with Marek, if you want to disable the fast bus,
then it should be board (or otherwise) controllable.


-- 
Regards,
Igor.
