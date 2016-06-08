From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 8 Jun 2016 09:59:26 +0100
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <5757CF9B.3080402@free.fr>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <5757CF9B.3080402@free.fr>
Message-ID: <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/16 08:56, Mason wrote:
> On 07/06/2016 13:30, Ben Dooks wrote:
> 
>> Fix the use of 0 instead of NULL to clk_get() call. This stops the
>> following warning:
>>
>> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> 
> May I ask which compiler/version produced that diagnostic?

I was running with "make C=2 bzImage" for ARM multi_v7_config

$ sparse --version
v0.5.0


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
