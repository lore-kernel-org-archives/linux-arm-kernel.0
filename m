From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 3 Feb 2012 10:43:02 +0100
Subject: [dmaengine] [Q] jiffies value does not increase in dma_sync_wait()
In-Reply-To: <20120203092456.GJ889@n2100.arm.linux.org.uk>
References: <CACKLOr26BuTh8Qr8pFHoTJoyCW9ty4-Kg-YRisXmN3=spzY6_Q@mail.gmail.com>
 <20120203091038.GI889@n2100.arm.linux.org.uk>
 <CACKLOr3_nsWy7z3QQejFbmgJJ78Nhv8J6fHFe=WjeAtghoCa5w@mail.gmail.com>
 <20120203092456.GJ889@n2100.arm.linux.org.uk>
Message-ID: <CACKLOr0sDkaEFFCaby6H1h3hofxJdDbr4LXaFMebGWZ-46EwiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2012 10:24, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 03, 2012 at 10:22:00AM +0100, javier Martin wrote:
>> Hi Russell,
>>
>> On 3 February 2012 10:10, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Feb 03, 2012 at 09:37:48AM +0100, javier Martin wrote:
>> >> I've introduced a couple of printk() to check why this timeout is not
>> >> triggered and I've found that the value of jiffies does not increase
>> >> between loop iterations (i. e. it's like time didn't advance).
>> >>
>> >> Does anyobody know what reasons could make jiffies not being updated?
>> >
>> > Are interrupts disabled?
>>
>> Apparently not but, how could I check it for sure? Is
>> "irqs_disabled()" suitable for that purpose?
>
> Yes.

"irqs_disabled()" returns 0 in every iteration of the loop. So I guess
this means IRQs are properly enabled, but jiffies keeps being fixed.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
