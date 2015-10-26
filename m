From: raghumag@gmail.com (raghu MG)
Date: Mon, 26 Oct 2015 12:19:31 +0530
Subject: How is jiffies upation while holding spinlock in Uniprocessor or SMP
 environment?
Message-ID: <CAG1O52Wq9uCXkOgttQ7gYECQsbFufug2LCBJQfNU309i5QNH6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I have couple of questions.
1) In case of UP how is jiffies(timer) get updated while holding spin
lock using spinlock_irq_save?

2)My understanding is in smp environment jiffies updation cannot be
done on processor holding spinlock irrespective of spinlock API.So
timer interrupt should be enabled across all cores in SoC. Imagine a
scenario in quad core processor where 4 cores are holding 4 different
spinlocks & how is the timer interrupt for jiffies handled?
