From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 31 Aug 2017 08:05:14 -0500
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <CAMuHMdXeWBbSkvwh_hpGhPe_s-GA8BptQPJWG_bu0Ln12N93Aw@mail.gmail.com>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com> <20170830161730.41919554@windsurf.lan>
 <CACRpkdbxdkHukALfYMrM7w=1KNJKLBhGebbkEpMb3C3+nCfWOA@mail.gmail.com>
 <20170831091812.6f7d417e@windsurf.lan>
 <CAMuHMdVGkTQ0vnOg5o+t1J9qe79ySm0R8aE4msyuNLoVGHLD6A@mail.gmail.com>
 <20170831092211.GP20805@n2100.armlinux.org.uk>
 <CAMuHMdXeWBbSkvwh_hpGhPe_s-GA8BptQPJWG_bu0Ln12N93Aw@mail.gmail.com>
Message-ID: <4f39d450-bc9c-b9a9-e3f8-b350e1770479@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2017 04:50 AM, Geert Uytterhoeven wrote:
>> For instance, you may have a timer block which can capture on both
>> edges of an external event signal, which needs the pin to be muxed for
>> that function.  However, you need to read the state of the pin, and
>> that is only available through GPIO.  Muxing the pin to be a GPIO just
>> because someone requests the GPIO is, imho, ill thought-out and breaks
>> some use cases.

> Yes, reading from the GPIO can work if the pin is muxed to another function.

Well that depends on the hardware.  On Qualcomm chips, the you can 
technically still read and write from/to the GPIO if it's muxed to some 
other function, but the results are meaningless.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
