From: stigge@antcom.de (Roland Stigge)
Date: Mon, 04 Jun 2012 17:02:28 +0200
Subject: [PATCH] ohci-nxp: Use ohci_finish_controller_resume()
In-Reply-To: <Pine.LNX.4.44L0.1206041027420.1555-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1206041027420.1555-100000@iolanthe.rowland.org>
Message-ID: <4FCCCE04.3000904@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 06/04/2012 04:29 PM, Alan Stern wrote:
>> OHCI drivers are supposed to use ohci_finish_controller_resume(). This patch
>> adds respective suspend and resume code to ohci-nxp. The following compiler
>> warning is fixed this way:
>>
>> drivers/usb/host/ohci-hub.c:321: warning: 'ohci_finish_controller_resume'
>> defined but not used
> 
> This is not a correct description of the patch.  A correct description 
> would be something like:
> 
> 	Add suspend/resume support to the ohci-nxp driver.
> 
> The compiler warning needs a completely different fix; 
> ohci_finish_controller_resume should be given a __maybe_unused 
> annotation.

Thanks for the suggestion! I'll rather do the latter.

Roland
