From: raghumag@gmail.com (raghu MG)
Date: Fri, 30 Oct 2015 16:29:25 +0530
Subject: How is jiffies upation while holding spinlock in Uniprocessor or
 SMP environment?
In-Reply-To: <20151026104854.GC8644@n2100.arm.linux.org.uk>
References: <CAG1O52Wq9uCXkOgttQ7gYECQsbFufug2LCBJQfNU309i5QNH6A@mail.gmail.com>
 <20151026104854.GC8644@n2100.arm.linux.org.uk>
Message-ID: <CAG1O52UE53vA8=aXUuBBeSTpiu0R+XYarW09WUDScc5_aW1u0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for clarifying.

On Mon, Oct 26, 2015 at 4:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 26, 2015 at 12:19:31PM +0530, raghu MG wrote:
>> Hello,
>> I have couple of questions.
>> 1) In case of UP how is jiffies(timer) get updated while holding spin
>> lock using spinlock_irq_save?
>
> It isn't, and...
>>
>> 2)My understanding is in smp environment jiffies updation cannot be
>> done on processor holding spinlock irrespective of spinlock API.So
>> timer interrupt should be enabled across all cores in SoC. Imagine a
>> scenario in quad core processor where 4 cores are holding 4 different
>> spinlocks & how is the timer interrupt for jiffies handled?
>
> You can't rely on jiffies being updated while holding a spinlock.
> Expecting jiffies to update while holding a spinlock is a bug.
>
> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
