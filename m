From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Feb 2014 11:52:06 +0000
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <CALicx6t7RSS_Zo9RGr76LMnNth1gQ7pukUtAmDY4gWRN5KGVKQ@mail.gmail.com>
References: <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
 <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
 <20140219113157.GG30457@arm.com> <20140219160359.GB22252@arm.com>
 <20140219161236.GG28173@mudshark.cambridge.arm.com>
 <CALicx6t7RSS_Zo9RGr76LMnNth1gQ7pukUtAmDY4gWRN5KGVKQ@mail.gmail.com>
Message-ID: <20140220115206.GD32456@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 06:58:25AM +0000, Vijay Kilari wrote:
> When I made below patch it works. I have tested with 4 cores on foundation model
> 
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -160,6 +160,8 @@ asmlinkage void secondary_start_kernel(void)
>         set_cpu_online(cpu, true);
>         complete(&cpu_running);
> 
> +       local_dbg_enable();
>         local_irq_enable();
>         local_async_enable();

I tested this as well and seems to work fine. I'll let Will comment on
whether this fix is enough and if yes, I'll fold it into one of your
patches (or push it on top of them).

-- 
Catalin
