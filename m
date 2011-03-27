From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 27 Mar 2011 18:56:58 +0200
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <1301240089.10831.2.camel@konomi> (Marek Vasut's message of "Sun\,
	27 Mar 2011 17\:34\:49 +0200")
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<201103271745.15216.anarsoul@gmail.com>
	<1301237445.10630.2.camel@konomi>
	<201103271756.19262.anarsoul@gmail.com>
	<1301240089.10831.2.camel@konomi>
Message-ID: <87r59sbixx.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut.n900@gmail.com> writes:

>> On Sunday 27 March 2011 17:50:45 Marek Vasut wrote:
>> > > On Sunday 27 March 2011 13:09:20 Igor Grinberg wrote:
>> > > > On 03/27/11 11:48, Vasily Khoruzhick wrote:
>> > > > > On Sunday 27 March 2011 12:09:21 Igor Grinberg wrote:
>> > > > > > Possibly, but Z2 is not the only one using PXA27x.
>> > > > > > And of course you lose performance, unless you don't care,
>> > > > > > because if it does not work at all, you don't care about
>> > > > > > performance, but again it is wrong to force all PXA27x based
>> > > > > > boards to this.
>> > > > > 
>> > > > > Ok, that's why I've sent this patch with RFC in subject - Z2 is
>> > > > > the only PXA270-based device I own :)
>> > > > > 
>> > > > > > cm-x270 and em-x270 work well with fast bus bit set with
>> > > > > > userspace governor and with the above frequencies.
>> > > > > 
>> > > > > What about ondemand and conservative governors?
These 2 work well on the mioa701 platform, under the constraint that the minimal
frequency is set to 208 instead of 104.

I would think as Marek that it's a under-voltage issue, unless it's the 104Mhz
transition issue which lasts for as long as I own my platform (and which might
be mioa701 specific AFAIK).

--
Robert
