From: liuj97@gmail.com (Jiang Liu)
Date: Mon, 14 Oct 2013 21:58:36 +0800
Subject: [RFT PATCH v2 1/4] arm64: fix possible invalid FPSIMD
 initialization state
In-Reply-To: <20131014135457.GE7682@arm.com>
References: <1381674029-430-1-git-send-email-liuj97@gmail.com>
 <20131014135457.GE7682@arm.com>
Message-ID: <525BF88C.4070608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 09:54 PM, Catalin Marinas wrote:
> On Sun, Oct 13, 2013 at 03:20:17PM +0100, Jiang Liu wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>> If context switching happens during executing fpsimd_flush_thread(),
>> stale value in FPSIMD registers will be saved into current thread's
>> fpsimd_state by fpsimd_thread_switch(). That may cause invalid
>> initialization state for the new process, so disable preemption
>> when executing fpsimd_flush_thread().
>>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Cc: Jiang Liu <liuj97@gmail.com>
> 
> That's already in mainline (3.12-rc4).
> 

Hi Catalin,
	I haven't noticed that yet, sorry for the noise:)
Thanks!
Gerry
