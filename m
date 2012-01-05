From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 5 Jan 2012 10:42:57 -0600
Subject: [RFC PATCH v2 1/2] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <20120105093240.GM11810@n2100.arm.linux.org.uk>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
 <20120105093240.GM11810@n2100.arm.linux.org.uk>
Message-ID: <CAMXH7KGeo9mtDdJ8oNiHMXrxz=4STWc+BabE=AQVNH_fUo=q9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2012 03:32, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 14, 2011 at 01:02:05AM -0600, Robert Lee wrote:
>> + ? ? asm("b 1f; .align 5; 1:");
>> + ? ? asm("mcr p15, 0, r0, c7, c10, 4"); ? ? ?/* drain write buffer */
>
> Err, no. ?The compiler is free to add whatever instructions it sees
> fit between these two asm() statements.
>
> If you want to ask the compiler to issue a set of assembly instructions
> as a block, you have to use just one asm() statement.

Thanks.  I will fix that in v3.
