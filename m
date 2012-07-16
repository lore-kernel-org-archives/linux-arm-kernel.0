From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 16 Jul 2012 14:38:49 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com>
 <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com>
 <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Message-ID: <50046DC9.80203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/16/2012 01:38 PM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Mon, 16 Jul 2012, Jon Hunter wrote:
> 
>> Yes I see that makes sense. However, patch #7 has already changed the
>> mapping of the flags. I had intended that patch #7 and #8 would be
>> applied together. However, I could see that patch #7 can be taken just
>> to eliminate using the SW_SLEEP state. So basically, what I am saying is
>> does patch #7 have any value without #8?
> 
> Certainly not as much value as it had before.  But my understanding, which 
> is possibly incorrect, matches what you wrote in patch #7's description:
> 
> "For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is 
> equivalent to SW_WKUP. The only difference between HW_AUTO and SW_SLEEP 
> for OMAP4 devices is that the PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt 
> status is set in case of SW_SLEEP transition, and not set in case of 
> HW_AUTO transition."
> 
> We don't use that PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt bit.  So if 
> SW_SLEEP and HW_AUTO really have identical meanings otherwise, then I 
> suppose we might as well use the one that does what we need with no 
> extraneous side-effects?  My recollection from a conversation with Beno?t 
> a few months ago was that this was his view as well.

Yes that is my understanding too. So from that standpoint it is fine to
keep. However, I just wanted to make sure I understood your thinking here.

>> That's fine with me. We can always workaround such issues by adding flags.
>>
>> I can give this a try this week and let you know how it goes.
> 
> Okay, great.  No rush on my account.

Ok. I have a few items on my plate that keep preventing me from getting
back to this, but what to get this done.

Jon
