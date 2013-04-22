From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Apr 2013 21:52:22 +0400
Subject: [PATCH v5 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <20130422145122.GQ14496@n2100.arm.linux.org.uk>
References: <201304200155.13492.sergei.shtylyov@cogentembedded.com>
 <20130422145122.GQ14496@n2100.arm.linux.org.uk>
Message-ID: <517578D6.2050409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Hello.

On 04/22/2013 06:51 PM, Russell King - ARM Linux wrote:

>
>> Hello.
>>
>>     Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
>> 'renesas-next-20130419' tag.  It was created to fix the shortcomings in the
>> R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
>> spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
>> to touch both subtrees). The patches were conceived with the complete
>> bisectability goal in mind.
>>
>> [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
>> [2/9] ehci-platform: add pre_setup() method to platform data
>> [3/9] ARM: shmobile: r8a7779: setup EHCI internal buffer
>> [4/9] rcar-phy: remove EHCI internal buffer setup
>> [5/9] ARM: shmobile: r8a7779: remove USB PHY 2nd memory resource
>> [6/9] rcar-phy: correct base address
>> [7/9] rcar-phy: add platform data
>> [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
>> [9/9] rcar-phy: handle platform data
> Please can you rethink how you use get_maintainers.pl and send out
> patches?
>
> Sending them "To" everyone who get_maintainers.pl spits out is all well
> and good, but it means that there's no discrimination between those who
> have a primary interest in the patches and those who don't.

    Heh, yet I completely ignore the "commit signers" list that it has
a habit to spitting out. :-)

> Examples of people with a primary interest: those maintaining the
> platforms and/or those who you want to merge your patches.  These
> should be on the To: line.
>
> Those who don't: everyone else who may have an interest - these go on
> the Cc: line.
>
> You're about the only person I regularly get patches for platforms which
> are sent To: me all the time, and really they are not "important" for
> me (though they are important enough for me to be Cc'd).

    OK, I'll try to make this distinction in the future. I just didn't 
think the
difference between To: and Cc: was really that important to anyone.

> What I'm saying is that having come back from a vacation last Tuesday,
> I could not just scan through this mailbox for all messages marked "To"
> me and treat those as being more important than everything else, because
> soo many of yours were captured by that.  And I'm still tacking the
> backlog today, almost a week later.

     Sorry about that.

> Please be more considerate to those who you're mailing.
>
> (Also, make sure you don't honor the Mail-Followup-To: header, which
> will lead your mailer to keep placing all recipients into the To:
> header on reply - because it breaks the above reasoning.  The To:
> header should be those recipients who you are directly discussing, and
> Cc: is for "interested side parties".)

    That would be somewhat tougher, as I'm usually quick to hit the send
button after completing the email, so can forget to change people from
To: list to CC: list... but I'll have to promise to try to give it more 
attention
from now on.

> Thanks.

WBR, Sergei
